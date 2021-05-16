/// The side of a block.
public enum MinecraftBlockFace: Int, Hashable, MinecraftEncodable, MinecraftDecodable {
    /// Side facing upwards.
    case top = 0
    /// Side facing downwards.
    case bottom = 1
    /// Side facing towards negative Z.
    case north = 2
    /// Side facing towards positive Z.
    case south = 3
    /// Side facing towards negative X.
    case west = 4
    /// Side facing towards positive X.
    case east = 5

    /// The direction the side is pointing towards.
    public var direction: Vec3<Int> {
        switch self {
        case .top: return Vec3(y: -1)
        case .bottom: return Vec3(y: 1)
        case .north: return Vec3(z: -1)
        case .south: return Vec3(z: 1)
        case .west: return Vec3(x: -1)
        case .east: return Vec3(x: 1)
        }
    }
}
