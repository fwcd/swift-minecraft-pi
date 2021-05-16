/// An event describing a block hit from a sword.
public struct MinecraftBlockHitEvent: Hashable, MinecraftEncodable, MinecraftDecodable {
    /// The position of the block.
    public let pos: Vec3<Int>
    /// The face of the block that was hit.
    public let face: MinecraftBlockFace
    /// The entity id hitting the block.
    public let entityId: Int

    public var minecraftEncoded: String {
        "\(pos.minecraftEncoded),\(face.minecraftEncoded),\(entityId.minecraftEncoded)"
    }

    public static func minecraftDecoded(from raw: String) throws -> Self {
        let components = raw.split(separator: ",").map(String.init)
        guard components.count == 5 else { throw MinecraftDecodingError.couldNotDecode("MinecraftBlockHitEvent", "Needs exactly 5 components: \(raw)") }
        return try Self(
            pos: Vec3(
                x: .minecraftDecoded(from: components[0]),
                y: .minecraftDecoded(from: components[1]),
                z: .minecraftDecoded(from: components[2])
            ),
            face: .minecraftDecoded(from: components[3]),
            entityId: .minecraftDecoded(from: components[4])
        )
    }
}
