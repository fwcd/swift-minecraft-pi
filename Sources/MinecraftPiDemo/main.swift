import MinecraftPi

let mc = try! Minecraft.connect()

mc.chat.post("Hello world!")
