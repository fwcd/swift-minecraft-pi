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
