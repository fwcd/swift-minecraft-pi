/// A 2D vector, e.g. representing a map position in the Minecraft world.
public struct Vec2<T>: Hashable, MinecraftEncodable, MinecraftDecodable
    where T: ExpressibleByIntegerLiteral & Hashable & MinecraftEncodable & MinecraftDecodable {
    public var x: T
    public var z: T

    public init(x: T = 0, z: T = 0) {
        self.x = x
        self.z = z
    }

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

extension Vec2: AdditiveArithmetic where T: AdditiveArithmetic {
    public static var zero: Self { Vec2() }

    public static func +(lhs: Self, rhs: Self) -> Self {
        Vec2<T>(x: lhs.x + rhs.x, z: lhs.z + rhs.z)
    }

    public static func -(lhs: Self, rhs: Self) -> Self {
        Vec2<T>(x: lhs.x - rhs.x, z: lhs.z - rhs.z)
    }

    public static func +=(lhs: inout Self, rhs: Self) {
        lhs.x += rhs.x
        lhs.z += rhs.z
    }

    public static func -=(lhs: inout Self, rhs: Self) {
        lhs.x -= rhs.x
        lhs.z -= rhs.z
    }
}

extension Vec2 where T: Numeric {
    public static func *(lhs: T, rhs: Self) -> Self {
        Vec2<T>(x: lhs * rhs.x, z: lhs * rhs.z)
    }

    public static func *(lhs: Self, rhs: T) -> Self {
        Vec2<T>(x: lhs.x * rhs, z: lhs.z * rhs)
    }

    public static func *=(lhs: inout Self, rhs: T) {
        lhs.x *= rhs
        lhs.z *= rhs
    }
}

extension Vec2 where T: SignedNumeric {
    public mutating func negate() {
        x.negate()
        z.negate()
    }

    public static prefix func -(operand: Self) -> Self {
        Vec2<T>(x: -operand.x, z: -operand.z)
    }
}

// Swift has no numeric protocol for '/', so we need to specialize here

extension Vec2 where T == Double {
    var asInt: Vec2<Int> { Vec2<Int>(x: Int(x), z: Int(z)) }
    var magnitude: Double { (x * x + z * z).squareRoot() }

    public static func /(lhs: Self, rhs: T) -> Self {
        Vec2<T>(x: lhs.x / rhs, z: lhs.z / rhs)
    }

    public static func /=(lhs: inout Self, rhs: T) {
        lhs.x /= rhs
        lhs.z /= rhs
    }
}

extension Vec2 where T == Int {
    var asDouble: Vec2<Double> { Vec2<Double>(x: Double(x), z: Double(z)) }
    var magnitude: Double { asDouble.magnitude }

    public static func /(lhs: Self, rhs: T) -> Self {
        Vec2<T>(x: lhs.x / rhs, z: lhs.z / rhs)
    }

    public static func /=(lhs: inout Self, rhs: T) {
        lhs.x /= rhs
        lhs.z /= rhs
    }
}
