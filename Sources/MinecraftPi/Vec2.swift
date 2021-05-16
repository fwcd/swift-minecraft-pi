/// A 2D vector, e.g. representing a map position in the Minecraft world.
public struct Vec2<T>: Hashable, MinecraftEncodable, MinecraftDecodable
    where T: ExpressibleByIntegerLiteral & Hashable & MinecraftEncodable & MinecraftDecodable {
    public var x: T = 0
    public var z: T = 0

    public var minecraftEncoded: String {
        "\(x.minecraftEncoded),\(z.minecraftEncoded)"
    }

    public static func minecraftDecoded(from raw: String) throws -> Self {
        let components = raw.split(separator: ",").map(String.init)
        guard components.count == 2 else { throw MinecraftDecodingError.couldNotDecode("Vec2", "Needs exactly 2 components: \(raw)") }
        return try Self(
            x: T.minecraftDecoded(from: components[0]),
            z: T.minecraftDecoded(from: components[1])
        )
    }
}
