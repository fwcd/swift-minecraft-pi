/// Represents something that can be converted from a
/// string representation in the MCPI protocol.
public protocol MinecraftDecodable {
    static func minecraftDecoded(from raw: String) throws -> Self
}

extension String: MinecraftDecodable {
    public static func minecraftDecoded(from raw: String) -> Self { raw }
}

extension Int: MinecraftDecodable {
    public static func minecraftDecoded(from raw: String) throws -> Self {
        guard let n = Self(raw) else { throw MinecraftDecodingError.couldNotDecode("Int", raw) }
        return n
    }
}

extension Float: MinecraftDecodable {
    public static func minecraftDecoded(from raw: String) throws -> Self {
        guard let x = Self(raw) else { throw MinecraftDecodingError.couldNotDecode("Float", raw) }
        return x
    }
}

extension Double: MinecraftDecodable {
    public static func minecraftDecoded(from raw: String) throws -> Self {
        guard let x = Self(raw) else { throw MinecraftDecodingError.couldNotDecode("Double", raw) }
        return x
    }
}
