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

extension Bool: MinecraftDecodable {
    public static func minecraftDecoded(from raw: String) throws -> Self {
        switch raw {
        case "0": return false
        case "1": return true
        default: throw MinecraftDecodingError.couldNotDecode("Bool", raw)
        }
    }
}

extension Array: MinecraftDecodable where Element: MinecraftDecodable {
    public static func minecraftDecoded(from raw: String) throws -> Self {
        let rawElements = raw.split(separator: "|")
        return try rawElements.map { try Element.minecraftDecoded(from: String($0)) }
    }
}

// Due to a limitation of Swift, we cannot directly conform RawRepresentable
// implementations to our protocol.
extension RawRepresentable where RawValue: MinecraftDecodable {
    public static func minecraftDecoded(from raw: String) throws -> Self {
        let rawValue = try RawValue.minecraftDecoded(from: raw)
        guard let x = Self(rawValue: rawValue) else { throw MinecraftDecodingError.couldNotDecode("RawRepresentable", raw) }
        return x
    }
}
