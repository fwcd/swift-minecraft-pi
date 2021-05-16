import MinecraftPi
import Foundation

let mc = try! Minecraft.connect()

// Post a message to the in-game-chat
mc.chat.post("Hello world!")

// Print the block the player is standing on.
print()

// Repeatedly poll information about the player
while true {
    Thread.sleep(forTimeInterval: 1)

    let hits = mc.events.block.hits
    let belowPlayer = mc.world.getBlock(at: mc.player.tile - Vec3(y: 1))
    let pos = mc.player.pos

    print("Hits: \(hits.count), block: \(belowPlayer.type), x: \(pos.x), y: \(pos.y), z: \(pos.z)")
}
