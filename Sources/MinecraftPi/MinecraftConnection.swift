import Socket

/// A connection to the running Minecraft Pi instance.
struct MinecraftConnection {
    let socket: Socket

    init(host: String, port: Int32) throws {
        socket = try Socket.create()
        try socket.connect(to: host, port: port)
    }

    func call(_ package: String, _ command: String, _ params: [String]) throws {
        try socket.write(from: "\(package).\(command)(\(params.joined(separator: ",")))\n")
    }

    func read() throws -> String {
        guard let s = try socket.readString() else { throw MinecraftConnectionError.noRead }
        return s
    }
}
