/// A 3D vector, e.g. representing a position in the Minecraft world.
public struct Vec3<T>: Hashable, MinecraftEncodable, MinecraftDecodable
    where T: ExpressibleByIntegerLiteral & Hashable & MinecraftEncodable & MinecraftDecodable {
    public var x: T = 0
    public var y: T = 0
    public var z: T = 0

    public var minecraftEncoded: String {
        "\(x.minecraftEncoded),\(y.minecraftEncoded),\(z.minecraftEncoded)"
    }

    public static func minecraftDecoded(from raw: String) throws -> Self {
        let components = raw.split(separator: ",").map(String.init)
        guard components.count == 3 else { throw MinecraftDecodingError.couldNotDecode("Vec3", "Needs exactly 3 components: \(raw)") }
        return try Self(
            x: T.minecraftDecoded(from: components[0]),
            y: T.minecraftDecoded(from: components[1]),
            z: T.minecraftDecoded(from: components[2])
        )
    }
}
