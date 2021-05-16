/// A 3D vector, e.g. representing a position in the Minecraft world.
public struct Vec3<T>: Hashable, MinecraftEncodable, MinecraftDecodable
    where T: Hashable & MinecraftEncodable & MinecraftDecodable {
    public let x: T
    public let y: T
    public let z: T

    public static func minecraftDecoded(from raw: String) throws -> Self {
        let components = raw.split(separator: ",").map(String.init)
        guard components.count == 3 else { throw MinecraftDecodingError.couldNotDecode("Vec3", "Needs exactly 3 components: \(raw)") }
        return try Self(
            x: T.minecraftDecoded(from: components[0]),
            y: T.minecraftDecoded(from: components[1]),
            z: T.minecraftDecoded(from: components[2])
        )
    }

    public var minecraftEncoded: String {
        "\(x.minecraftEncoded),\(y.minecraftEncoded),\(z.minecraftEncoded)"
    }
}
