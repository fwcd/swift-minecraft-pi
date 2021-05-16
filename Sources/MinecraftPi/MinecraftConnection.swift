import Socket
import Foundation

/// A connection to the running Minecraft Pi instance.
class MinecraftConnection {
    private let socket: Socket
    private var buffer: Data = Data()

    init(host: String, port: Int32) throws {
        socket = try Socket.create()
        try socket.connect(to: host, port: port)
    }

    /// Writes the given method call.
    func call(_ package: String, _ command: String, _ params: [MinecraftEncodable] = []) throws {
        let msg = "\(package).\(command)(\(params.map { $0.minecraftEncoded }.joined(separator: ",")))\n"
        try socket.write(from: msg)
    }

    /// Reads the next line and decodes it to a custom object.
    func read<D>() throws -> D where D: MinecraftDecodable {
        repeat {
            try socket.read(into: &buffer)
        } while try socket.isReadableOrWritable().readable

        var lineData = Data()

        while let b = buffer.popFirst(), b != 0x0A { // ASCII line feed
            lineData.append(b)
        }

        guard let rawLine = String(data: lineData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) else { throw MinecraftConnectionError.couldNotRead }

        return try D.minecraftDecoded(from: rawLine)
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

        func call(_ command: String, _ params: [MinecraftEncodable] = []) throws {
            try connection.call(package, command, params)
        }

        func read<D>() throws -> D where D: MinecraftDecodable {
            try connection.read()
        }

        func wrapper(for subpackage: String) -> Wrapper {
            Wrapper(connection: connection, package: "\(package).\(subpackage)")
        }
    }
}
