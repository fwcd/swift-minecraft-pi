/// A block type in the Minecraft world.
public struct MinecraftBlock: Hashable, MinecraftEncodable, MinecraftDecodable {
    public var type: BlockType
    public var data: BlockData? = nil

    public struct BlockType: Hashable, RawRepresentable, MinecraftEncodable, MinecraftDecodable {
        public var rawValue: Int

        public static let air = Self(rawValue: 0)
        public static let stone = Self(rawValue: 1)
        public static let grass = Self(rawValue: 2)
        public static let dirt = Self(rawValue: 3)
        public static let cobblestone = Self(rawValue: 4)
        public static let woordPlanks = Self(rawValue: 5)
        public static let sapling = Self(rawValue: 6)
        public static let bedrock = Self(rawValue: 7)
        public static let water = Self(rawValue: 8)
        public static let waterStationary = Self(rawValue: 9)
        public static let lava = Self(rawValue: 10)
        public static let lavaStationary = Self(rawValue: 11)
        public static let sand = Self(rawValue: 12)
        public static let gravel = Self(rawValue: 13)
        public static let goldOre = Self(rawValue: 14)
        public static let ironOre = Self(rawValue: 15)
        public static let coalOre = Self(rawValue: 16)
        public static let wood = Self(rawValue: 17)
        public static let leaves = Self(rawValue: 18)
        public static let glass = Self(rawValue: 20)
        public static let lapisLazuliOre = Self(rawValue: 21)
        public static let lapisLazuliBlock = Self(rawValue: 22)
        public static let sandstone = Self(rawValue: 24)
        public static let bed = Self(rawValue: 26)
        public static let railPowered = Self(rawValue: 27)
        public static let railDetector = Self(rawValue: 28)
        public static let cobweb = Self(rawValue: 30)
        public static let grassTall = Self(rawValue: 31)
        public static let deadBush = Self(rawValue: 32)
        public static let wool = Self(rawValue: 35)
        public static let flowerYellow = Self(rawValue: 37)
        public static let flowerCyan = Self(rawValue: 38)
        public static let mushroomBrown = Self(rawValue: 39)
        public static let mushroomRed = Self(rawValue: 40)
        public static let goldBlock = Self(rawValue: 41)
        public static let ironBlock = Self(rawValue: 42)
        public static let stoneSlabDouble = Self(rawValue: 43)
        public static let stoneSlab = Self(rawValue: 44)
        public static let brickBlock = Self(rawValue: 45)
        public static let tnt = Self(rawValue: 46)
        public static let bookshelf = Self(rawValue: 47)
        public static let mossStone = Self(rawValue: 48)
        public static let obsidian = Self(rawValue: 49)
        public static let torch = Self(rawValue: 50)
        public static let fire = Self(rawValue: 51)
        public static let stairsWood = Self(rawValue: 53)
        public static let chest = Self(rawValue: 54)
        public static let diamondOre = Self(rawValue: 56)
        public static let diamondBlock = Self(rawValue: 57)
        public static let craftingTable = Self(rawValue: 58)
        public static let farmland = Self(rawValue: 60)
        public static let furnaceInactive = Self(rawValue: 61)
        public static let furnaceActive = Self(rawValue: 62)
        public static let signStanding = Self(rawValue: 63)
        public static let doorWood = Self(rawValue: 64)
        public static let ladder = Self(rawValue: 65)
        public static let rail = Self(rawValue: 66)
        public static let stairsCobblestone = Self(rawValue: 67)
        public static let signWall = Self(rawValue: 68)
        public static let doorIron = Self(rawValue: 71)
        public static let redstoneOre = Self(rawValue: 73)
        public static let torchRedstone = Self(rawValue: 76)
        public static let snow = Self(rawValue: 78)
        public static let ice = Self(rawValue: 79)
        public static let snowBlock = Self(rawValue: 80)
        public static let cactus = Self(rawValue: 81)
        public static let clay = Self(rawValue: 82)
        public static let sugarCane = Self(rawValue: 83)
        public static let fence = Self(rawValue: 85)
        public static let pumpkin = Self(rawValue: 86)
        public static let netherrack = Self(rawValue: 87)
        public static let soulSand = Self(rawValue: 88)
        public static let glowstoneBlock = Self(rawValue: 89)
        public static let litPumpkin = Self(rawValue: 91)
        public static let invisibleBedrock = Self(rawValue: 95)
        public static let trapdoor = Self(rawValue: 96)
        public static let stoneBrick = Self(rawValue: 98)
        public static let glassPane = Self(rawValue: 102)
        public static let melon = Self(rawValue: 103)
        public static let fenceGate = Self(rawValue: 107)
        public static let stairsBrick = Self(rawValue: 108)
        public static let stairsStoneBrick = Self(rawValue: 109)
        public static let mycelium = Self(rawValue: 110)
        public static let netherBrick = Self(rawValue: 112)
        public static let fenceNetherBrick = Self(rawValue: 113)
        public static let stairsNetherBrick = Self(rawValue: 114)
        public static let endStone = Self(rawValue: 121)
        public static let woodenSlab = Self(rawValue: 126)
        public static let stairsSandstone = Self(rawValue: 128)
        public static let emeraldOre = Self(rawValue: 129)
        public static let railActivator = Self(rawValue: 157)
        public static let leaves2 = Self(rawValue: 161)
        public static let trapdoorIron = Self(rawValue: 167)
        public static let fenceSpruce = Self(rawValue: 188)
        public static let fenceBirch = Self(rawValue: 189)
        public static let fenceJungle = Self(rawValue: 190)
        public static let fenceDarkOak = Self(rawValue: 191)
        public static let fenceAcacia = Self(rawValue: 192)
        public static let doorSpruce = Self(rawValue: 193)
        public static let doorBirch = Self(rawValue: 194)
        public static let doorJungle = Self(rawValue: 195)
        public static let doorAcacia = Self(rawValue: 196)
        public static let doorDarkOak = Self(rawValue: 197)
        public static let glowingObsidian = Self(rawValue: 246)
        public static let netherReactorCore = Self(rawValue: 247)

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }

    public struct BlockData: Hashable, RawRepresentable, MinecraftEncodable, MinecraftDecodable {
        public var rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }

    public var minecraftEncoded: String {
        [type.minecraftEncoded, data?.minecraftEncoded].compactMap { $0 }.joined(separator: ",")
    }

    public static func minecraftDecoded(from raw: String) throws -> Self {
        let components = raw.split(separator: ",").map(String.init)
        guard (1...2).contains(components.count) else { throw MinecraftDecodingError.couldNotDecode("MinecraftBlock", "Needs one or two components: \(raw)") }
        return try Self(
            type: BlockType.minecraftDecoded(from: components[0]),
            data: components[safely: 1].map { try BlockData.minecraftDecoded(from: $0) }
        )
    }
}
