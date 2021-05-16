public struct Minecraft {
    private let connection: MinecraftConnection

    public init(host: String = "localhost", port: Int32 = 4711) throws {
        connection = try MinecraftConnection(host: host, port: port)
    }
}
