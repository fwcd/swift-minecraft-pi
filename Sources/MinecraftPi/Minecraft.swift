/// The high-level API for interfacing with Minecraft Pi.
/// Protocol reference: https://wiki.vg/Minecraft_Pi_Protocol
public struct Minecraft {
    private let connection: MinecraftConnection

    public let chat: Chat
    public let player: Player
    public let entities: Entities
    public let world: World
    public let camera: Camera
    public let events: Events

    init(connection: MinecraftConnection) {
        self.connection = connection

        chat = Chat(connection: connection.wrapper(for: "chat"))
        player = Player(connection: connection.wrapper(for: "player"))
        entities = Entities(connection: connection.wrapper(for: "entity"))
        world = World(connection: connection.wrapper(for: "world"))
        camera = Camera(connection: connection.wrapper(for: "camera"))
        events = Events(connection: connection.wrapper(for: "events"))
    }

    /// Connects to a running Minecraft Pi Edition instance on the given address.
    public static func connect(host: String = "localhost", port: Int32 = 4711) throws -> Self {
        Self(connection: try MinecraftConnection(host: host, port: port))
    }

    /// The in-game chat.
    public struct Chat {
        private let connection: MinecraftConnection.Wrapper

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection
        }

        /// Posts a message to the in-game chat.
        public func post(_ message: String) {
            try! connection.call("post", [message])
        }
    }

    /// The player in the game.
    public struct Player {
        private let connection: MinecraftConnection.Wrapper

        /// The player's precise position.
        public var pos: Vec3<Double> {
            get {
                try! connection.call("getPos")
                return try! connection.read()
            }
            set {
                try! connection.call("setPos", [newValue])
            }
        }

        /// The player's nearest block.
        public var tile: Vec3<Int> {
            get {
                try! connection.call("getTile")
                return try! connection.read()
            }
            set {
                try! connection.call("setTile", [newValue])
            }
        }

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection
        }

        /// A player setting.
        public enum Setting: String, MinecraftEncodable, MinecraftDecodable {
            case autojump
        }

        /// Sets a setting on the player.
        public func setting(_ key: Setting, _ value: MinecraftEncodable) {
            try! connection.call("setting", [key, value])
        }
    }

    /// The world and terrain.
    public struct World {
        private let connection: MinecraftConnection.Wrapper

        public let checkpoint: Checkpoint

        /// The entity ids of all connected players.
        public var playerIds: [Int] {
            try! connection.read()
        }

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection

            checkpoint = Checkpoint(connection: connection.wrapper(for: "checkpoint"))
        }

        /// Fetches the block at the specified position.
        public func getBlock(x: Int, y: Int, z: Int) -> MinecraftBlock {
            return getBlock(at: Vec3(x: x, y: y, z: z))
        }

        /// Fetches the block at the specified position.
        public func getBlock(at pos: Vec3<Int>) -> MinecraftBlock {
            try! connection.call("getBlockWithData", [pos])
            return try! connection.read()
        }

        /// Sets the block at the given position to the specified block type.
        public func setBlock(at pos: Vec3<Int>, to blockType: MinecraftBlock.BlockType) {
            setBlock(at: pos, to: MinecraftBlock(type: blockType))
        }

        /// Sets the block at the given position.
        public func setBlock(at pos: Vec3<Int>, to block: MinecraftBlock) {
            try! connection.call("setBlock", [pos, block])
        }

        /// Sets all blocks in the cuboid defined by the given two corners to the specified block type.
        public func setBlocks(between corner1: Vec3<Int>, and corner2: Vec3<Int>, to blockType: MinecraftBlock.BlockType) {
            setBlocks(between: corner1, and: corner2, to: MinecraftBlock(type: blockType))
        }

        /// Sets all blocks in the cuboid defined by the given two corners.
        public func setBlocks(between corner1: Vec3<Int>, and corner2: Vec3<Int>, to block: MinecraftBlock) {
            try! connection.call("setBlocks", [corner1, corner2, block])
        }

        /// Fetches the y-coordinate of the topmost non-solid block.
        public func getHeight(at pos: Vec2<Int>) -> Int {
            try! connection.call("getHeight", [pos])
            return try! connection.read()
        }

        /// A world setting.
        public enum Setting: String, MinecraftEncodable, MinecraftDecodable {
            case worldImmutable = "world_immutable"
            case nametagsVisible = "nametags_visible"
        }

        /// Sets a setting of the world.
        public func setting(_ key: Setting, _ value: MinecraftEncodable) {
            try! connection.call("setting", [key, value])
        }

        /// A facility for saving/restoring the world state.
        public struct Checkpoint {
            private let connection: MinecraftConnection.Wrapper

            init(connection: MinecraftConnection.Wrapper) {
                self.connection = connection
            }

            /// Saves a checkpoint that can be used to restore the world state.
            public func save() {
                try! connection.call("save")
            }

            /// Restores the world to the last checkpoint.
            public func restore() {
                try! connection.call("restore")
            }
        }
    }

    /// The entities in the game.
    public struct Entities {
        private let connection: MinecraftConnection.Wrapper

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection
        }

        /// Fetches the block position of the given entity.
        public func getTile(of entityId: Int) -> Vec3<Int> {
            try! connection.call("getTile", [entityId])
            return try! connection.read()
        }

        /// Sets the block position of the given entity.
        public func setTile(of entityId: Int, to pos: Vec3<Int>) {
            try! connection.call("setTile", [entityId, pos])
        }

        /// Fetches the exact position of the given entity.
        public func getPos(of entityId: Int) -> Vec3<Double> {
            try! connection.call("getPos", [entityId])
            return try! connection.read()
        }

        /// Sets the exact position of the given entity.
        public func setPos(of entityId: Int, to pos: Vec3<Double>) {
            try! connection.call("setPos", [entityId, pos])
        }
    }

    /// The player's camera in the game.
    public struct Camera {
        private let connection: MinecraftConnection.Wrapper

        public let mode: Mode

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection
            
            mode = Mode(connection: connection.wrapper(for: "mode"))
        }

        /// The camera's mode.
        public struct Mode {
            private let connection: MinecraftConnection.Wrapper

            init(connection: MinecraftConnection.Wrapper) {
                self.connection = connection
            }

            /// Switches to normal camera mode.
            public func setNormal() {
                try! connection.call("setNormal")
            }

            /// Switches to third-person camera mode.
            public func setThirdPerson() {
                try! connection.call("setFollow")
            }

            /// Switches to third-person camera mode following the given entity.
            public func setFollow(_ entityId: Int) {
                try! connection.call("setFollow", [entityId])
            }

            /// Switches to a fixed camera position.
            public func setFixed() {
                try! connection.call("setFixed")
            }

            /// Sets the camera position explicitly.
            public func setPos(x: Double, y: Double, z: Double) {
                setPos(to: Vec3(x: x, y: y, z: z))
            }

            /// Sets the camera position explicitly.
            public func setPos(to pos: Vec3<Double>) {
                try! connection.call("setPos", [pos])
            }
        }
    }

    /// Events occuring in the game.
    public struct Events {
        private let connection: MinecraftConnection.Wrapper

        public let block: Block

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection

            block = Block(connection: connection.wrapper(for: "block"))
        }

        /// Clears old events.
        public func clear() {
            try! connection.call("clear")
        }

        /// Block-related events.
        public struct Block {
            private let connection: MinecraftConnection.Wrapper

            /// Events triggered by right-clicking with a sword on blocks.
            public var hits: [MinecraftBlockHitEvent] {
                try! connection.read()
            }

            init(connection: MinecraftConnection.Wrapper) {
                self.connection = connection
            }
        }
    }
}
