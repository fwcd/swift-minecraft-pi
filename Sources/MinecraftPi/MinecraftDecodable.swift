/// Represents something that can be converted from a
/// string representation in the MCPI protocol.
protocol MinecraftDecodable {
    static func decoded(from raw: String) throws -> Self
}

extension String: MinecraftDecodable {
    static func decoded(from raw: String) -> Self { raw }
}

extension Int: MinecraftDecodable {
    static func decoded(from raw: String) throws -> Self {
        guard let n = Self(raw) else { throw MinecraftDecodingError.couldNotDecode("Int", raw) }
        return n
    }
}

extension Float: MinecraftDecodable {
    static func decoded(from raw: String) throws -> Self {
        guard let x = Self(raw) else { throw MinecraftDecodingError.couldNotDecode("Float", raw) }
        return x
    }
}

extension Double: MinecraftDecodable {
    static func decoded(from raw: String) throws -> Self {
        guard let x = Self(raw) else { throw MinecraftDecodingError.couldNotDecode("Double", raw) }
        return x
    }
}
