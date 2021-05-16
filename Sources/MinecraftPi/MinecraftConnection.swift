import Socket
import Foundation

/// A connection to the running Minecraft Pi instance.
class MinecraftConnection {
    private let socket: Socket

    init(host: String, port: Int32) throws {
        socket = try Socket.create()
        try socket.connect(to: host, port: port)
    }

    func call(_ package: String, _ command: String, _ params: [MinecraftEncodable]) throws {
        let msg = "\(package).\(command)(\(params.map { $0.encoded() }.joined(separator: ",")))\n"
        try socket.write(from: msg)
    }

    func read<D>() throws -> D where D: MinecraftDecodable {
        guard let raw = try socket.readString()?.trimmingCharacters(in: .whitespacesAndNewlines) else { throw MinecraftConnectionError.couldNotRead }
        return try D.decoded(from: raw)
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

        func wrapper(for subpackage: String) -> Wrapper {
            Wrapper(connection: connection, package: "\(package).\(subpackage)")
        }
    }
}
