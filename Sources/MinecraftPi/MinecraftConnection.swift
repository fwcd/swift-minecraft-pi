import Socket

/// A connection to the running Minecraft Pi instance.
class MinecraftConnection {
    private let socket: Socket

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

    func wrapper(for package: String) -> Wrapper {
        Wrapper(connection: self, package: package)
    }

    /// A wrapper around a connection for calling methods of a certain package.
    struct Wrapper {
        private let connection: MinecraftConnection
        private let package: String

        init(connection: MinecraftConnection, package: String) {
            self.connection = connection
            self.package = package
        }

        func call(_ command: String, _ params: [String]) throws {
            try connection.call(package, command, params)
        }

        func read() throws -> String {
            try connection.read()
        }
    }
}
