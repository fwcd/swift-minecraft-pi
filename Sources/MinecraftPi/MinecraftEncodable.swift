/// Represents something that can be converted to a
/// string representation in the MCPI protocol.
public protocol MinecraftEncodable {
    var minecraftEncoded: String { get }
}

extension String: MinecraftEncodable {
    public var minecraftEncoded: String { self }
}

extension Int: MinecraftEncodable {
    public var minecraftEncoded: String { String(self) }
}

extension Float: MinecraftEncodable {
    public var minecraftEncoded: String { String(self) }
}

extension Double: MinecraftEncodable {
    public var minecraftEncoded: String { String(self) }
}

extension Bool: MinecraftEncodable {
    public var minecraftEncoded: String { self ? "1" : "0" }
}

extension Array: MinecraftEncodable where Element: MinecraftEncodable {
    public var minecraftEncoded: String {
        map { $0.minecraftEncoded }.joined(separator: "|")
    }
}

// Due to a limitation of Swift, we cannot directly conform RawRepresentable
// implementations to our protocol.
extension RawRepresentable where RawValue: MinecraftEncodable {
    public var minecraftEncoded: String { rawValue.minecraftEncoded }
}
