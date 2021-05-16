/// Represents something that can be converted to a
/// string representation in the MCPI protocol.
protocol MinecraftEncodable {
    func encoded() -> String
}

extension String: MinecraftEncodable {
    func encoded() -> String { self }
}

extension Int: MinecraftEncodable {
    func encoded() -> String { String(self) }
}

extension Float: MinecraftEncodable {
    func encoded() -> String { String(self) }
}

extension Double: MinecraftEncodable {
    func encoded() -> String { String(self) }
}
