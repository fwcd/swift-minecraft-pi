import MinecraftPi
import Foundation

let mc = try! Minecraft.connect()

// Post a message to the in-game-chat
mc.chat.post("Hello world!")

while true {
    Thread.sleep(forTimeInterval: 0.1)

    let belowPlayer = mc.world.getBlock(at: mc.player.tile - Vec3(y: 1))
    let pos = mc.player.pos

    // Erase the line
    print("\u{1b}[2K\r", terminator: "")

    // Print some info about the player
    print("Block: \(belowPlayer.type), x: \(pos.x), y: \(pos.y), z: \(pos.z)", terminator: "")
    fflush(stdout)

    // Turn anything the player right-clicked with a sword into a gold block
    for hit in mc.events.block.hits {
        mc.world.setBlock(at: hit.pos, to: .goldBlock)
    }
}
