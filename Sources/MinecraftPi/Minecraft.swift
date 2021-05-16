/// The high-level API for interfacing with Minecraft Pi.
public struct Minecraft {
    private let connection: MinecraftConnection

    let chat: Chat

    public init(host: String = "localhost", port: Int32 = 4711) throws {
        connection = try MinecraftConnection(host: host, port: port)

        chat = Chat(connection: connection.wrapper(for: "world"))
    }

    public struct Chat {
        private let connection: MinecraftConnection.Wrapper

        init(connection: MinecraftConnection.Wrapper) {
            self.connection = connection
        }

        func post(_ message: String) {
            try! connection.call("post", [message])
        }
    }
}
