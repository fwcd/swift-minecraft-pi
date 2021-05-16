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
                try! connection.call("getPos", [])
                return try! connection.read()
            }
            set {
                try! connection.call("setPos", [newValue.x, newValue.y, newValue.z])
            }
        }

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection
        }
    }

    /// The world and terrain.
    public struct World {
        private let connection: MinecraftConnection.Wrapper

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection
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
