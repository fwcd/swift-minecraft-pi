import MinecraftPi
import Foundation

let mc = try! Minecraft.connect()

// Post a message to the in-game-chat
mc.chat.post("Hello world!")

// Repeatedly poll block hit events
while true {
    Thread.sleep(forTimeInterval: 1)
    print(mc.events.block.hits)
}
