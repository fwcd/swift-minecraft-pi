/// A block type in the Minecraft world.
public struct MinecraftBlock: Hashable, MinecraftEncodable, MinecraftDecodable {
    public var type: BlockType
    public var data: BlockData? = nil

    public enum BlockType: Int, Hashable, CustomStringConvertible, MinecraftEncodable, MinecraftDecodable {
        case air = 0
        case stone = 1
        case grass = 2
        case dirt = 3
        case cobblestone = 4
        case woordPlanks = 5
        case sapling = 6
        case bedrock = 7
        case water = 8
        case waterStationary = 9
        case lava = 10
        case lavaStationary = 11
        case sand = 12
        case gravel = 13
        case goldOre = 14
        case ironOre = 15
        case coalOre = 16
        case wood = 17
        case leaves = 18
        case glass = 20
        case lapisLazuliOre = 21
        case lapisLazuliBlock = 22
        case sandstone = 24
        case bed = 26
        case railPowered = 27
        case railDetector = 28
        case cobweb = 30
        case grassTall = 31
        case deadBush = 32
        case wool = 35
        case flowerYellow = 37
        case flowerCyan = 38
        case mushroomBrown = 39
        case mushroomRed = 40
        case goldBlock = 41
        case ironBlock = 42
        case stoneSlabDouble = 43
        case stoneSlab = 44
        case brickBlock = 45
        case tnt = 46
        case bookshelf = 47
        case mossStone = 48
        case obsidian = 49
        case torch = 50
        case fire = 51
        case stairsWood = 53
        case chest = 54
        case diamondOre = 56
        case diamondBlock = 57
        case craftingTable = 58
        case farmland = 60
        case furnaceInactive = 61
        case furnaceActive = 62
        case signStanding = 63
        case doorWood = 64
        case ladder = 65
        case rail = 66
        case stairsCobblestone = 67
        case signWall = 68
        case doorIron = 71
        case redstoneOre = 73
        case torchRedstone = 76
        case snow = 78
        case ice = 79
        case snowBlock = 80
        case cactus = 81
        case clay = 82
        case sugarCane = 83
        case fence = 85
        case pumpkin = 86
        case netherrack = 87
        case soulSand = 88
        case glowstoneBlock = 89
        case litPumpkin = 91
        case invisibleBedrock = 95
        case trapdoor = 96
        case stoneBrick = 98
        case glassPane = 102
        case melon = 103
        case fenceGate = 107
        case stairsBrick = 108
        case stairsStoneBrick = 109
        case mycelium = 110
        case netherBrick = 112
        case fenceNetherBrick = 113
        case stairsNetherBrick = 114
        case endStone = 121
        case woodenSlab = 126
        case stairsSandstone = 128
        case emeraldOre = 129
        case railActivator = 157
        case leaves2 = 161
        case trapdoorIron = 167
        case fenceSpruce = 188
        case fenceBirch = 189
        case fenceJungle = 190
        case fenceDarkOak = 191
        case fenceAcacia = 192
        case doorSpruce = 193
        case doorBirch = 194
        case doorJungle = 195
        case doorAcacia = 196
        case doorDarkOak = 197
        case glowingObsidian = 246
        case netherReactorCore = 247

        public var description: String {
            ".\(String(reflecting: self).split(separator: ".").last!)"
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
