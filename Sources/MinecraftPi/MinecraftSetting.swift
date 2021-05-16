/// An in-game setting.
public enum MinecraftSetting: String, MinecraftEncodable, MinecraftDecodable {
    case autojump
    
    public var minecraftEncoded: String { rawValue }

    public static func minecraftDecoded(from raw: String) throws -> Self {
        guard let setting = Self(rawValue: raw) else { throw MinecraftDecodingError.couldNotDecode("MinecraftSetting", raw) }
        return setting
    }
}
