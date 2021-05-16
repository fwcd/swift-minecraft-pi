/// The high-level API for interfacing with Minecraft Pi.
public struct Minecraft {
    private let connection: MinecraftConnection

    public let chat: Chat

    init(connection: MinecraftConnection) {
        self.connection = connection

        chat = Chat(connection: connection.wrapper(for: "chat"))
    }

    public static func connect(host: String = "localhost", port: Int32 = 4711) throws -> Self {
        Self(connection: try MinecraftConnection(host: host, port: port))
    }

    public struct Chat {
        private let connection: MinecraftConnection.Wrapper

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection
        }

        public func post(_ message: String) {
            try! connection.call("post", [message])
        }
    }
}
