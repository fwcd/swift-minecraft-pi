/// A 3D grid position in the Minecraft world.
public struct BlockPos: Hashable, MinecraftEncodable, MinecraftDecodable {
    public let x: Int
    public let y: Int
    public let z: Int

    static func decoded(from raw: String) throws -> Self {
        let components = raw.split(separator: ",").map(String.init)
        guard components.count == 3 else { throw MinecraftDecodingError.couldNotDecode("BlockPos", "Needs exactly 3 components: \(raw)") }
        return try Self(
            x: Int.decoded(from: components[0]),
            y: Int.decoded(from: components[1]),
            z: Int.decoded(from: components[2])
        )
    }

    func encoded() -> String {
        "\(x),\(y),\(z)"
    }
}
