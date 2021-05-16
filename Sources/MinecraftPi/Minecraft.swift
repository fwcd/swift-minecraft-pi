/// The high-level API for interfacing with Minecraft Pi.
public struct Minecraft {
    private let connection: MinecraftConnection

    public let chat: Chat
    public let player: Player
    public let entity: Entity
    public let world: World
    public let camera: Camera
    public let events: Events

    init(connection: MinecraftConnection) {
        self.connection = connection

        chat = Chat(connection: connection.wrapper(for: "chat"))
        player = Player(connection: connection.wrapper(for: "player"))
        entity = Entity(connection: connection.wrapper(for: "entity"))
        world = World(connection: connection.wrapper(for: "world"))
        camera = Camera(connection: connection.wrapper(for: "camera"))
        events = Events(connection: connection.wrapper(for: "events"))
    }

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

        public enum Setting: String, MinecraftEncodable, MinecraftDecodable {
            case autojump
        }

        /// Sets a setting on the player.
        public func setting(_ key: Setting, _ value: MinecraftEncodable) {
            try! connection.call(key.minecraftEncoded, [value])
        }
    }

    /// The world and terrain.
    public struct World {
        private let connection: MinecraftConnection.Wrapper

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection
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
    }

    /// The entities in the game.
    public struct Entity {
        private let connection: MinecraftConnection.Wrapper

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection
        }
    }

    /// The player's camera in the game.
    public struct Camera {
        private let connection: MinecraftConnection.Wrapper

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection
        }
    }

    /// Events occuring in the game.
    public struct Events {
        private let connection: MinecraftConnection.Wrapper

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection
        }
    }
}
