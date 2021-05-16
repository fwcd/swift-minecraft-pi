import MinecraftPi

let mc = try! Minecraft.connect()

// Post a message to the in-game chat
mc.chat.post("Hello world!")

// Print previous block events
print(mc.events.block.hits)
