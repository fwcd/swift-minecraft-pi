/// A 3D vector, e.g. representing a position in the Minecraft world.
public struct Vec3<T>: Hashable, MinecraftEncodable, MinecraftDecodable
    where T: ExpressibleByIntegerLiteral & Hashable & MinecraftEncodable & MinecraftDecodable {
    public var x: T
    public var y: T
    public var z: T

    public init(x: T = 0, y: T = 0, z: T = 0) {
        self.x = x
        self.y = y
        self.z = z
    }

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

extension Vec3: AdditiveArithmetic where T: AdditiveArithmetic {
    public static var zero: Self { Vec3() }

    public static func +(lhs: Self, rhs: Self) -> Self {
        Vec3<T>(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

    public static func -(lhs: Self, rhs: Self) -> Self {
        Vec3<T>(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }

    public static func +=(lhs: inout Self, rhs: Self) {
        lhs.x += rhs.x
        lhs.y += rhs.y
        lhs.z += rhs.z
    }

    public static func -=(lhs: inout Self, rhs: Self) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
        lhs.z -= rhs.z
    }
}

extension Vec3 where T: Numeric {
    public static func *(lhs: T, rhs: Self) -> Self {
        Vec3<T>(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z)
    }

    public static func *(lhs: Self, rhs: T) -> Self {
        Vec3<T>(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
    }

    public static func *=(lhs: inout Self, rhs: T) {
        lhs.x *= rhs
        lhs.y *= rhs
        lhs.z *= rhs
    }
}

extension Vec3 where T: SignedNumeric {
    public mutating func negate() {
        x.negate()
        y.negate()
        z.negate()
    }

    public static prefix func -(operand: Self) -> Self {
        Vec3<T>(x: -operand.x, y: -operand.y, z: -operand.z)
    }
}

// Swift has no numeric protocol for '/', so we need to specialize here

extension Vec3 where T == Double {
    var asInt: Vec3<Int> { Vec3<Int>(x: Int(x), y: Int(y), z: Int(z)) }
    var magnitude: Double { (x * x + y * y + z * z).squareRoot() }

    public static func /(lhs: Self, rhs: T) -> Self {
        Vec3<T>(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
    }

    public static func /=(lhs: inout Self, rhs: T) {
        lhs.x /= rhs
        lhs.y /= rhs
        lhs.z /= rhs
    }
}

extension Vec3 where T == Int {
    var asDouble: Vec3<Double> { Vec3<Double>(x: Double(x), y: Double(y), z: Double(z)) }
    var magnitude: Double { asDouble.magnitude }

    public static func /(lhs: Self, rhs: T) -> Self {
        Vec3<T>(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
    }

    public static func /=(lhs: inout Self, rhs: T) {
        lhs.x /= rhs
        lhs.y /= rhs
        lhs.z /= rhs
    }
}
