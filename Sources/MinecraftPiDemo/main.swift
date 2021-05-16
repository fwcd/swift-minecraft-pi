import MinecraftPi
import Foundation

let mc = try! Minecraft.connect()

// Post a message to the in-game-chat
mc.chat.post("Hello world!")

// Print the block the player is standing in.
let tile = mc.player.tile
print(mc.world.getBlock(at: tile))

// Repeatedly poll block hit events
while true {
    Thread.sleep(forTimeInterval: 1)
    print(mc.events.block.hits)
}
