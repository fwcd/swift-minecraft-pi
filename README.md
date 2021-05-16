# Minecraft Pi API for Swift

[![Build](https://github.com/fwcd/swift-minecraft-pi/actions/workflows/linux.yml/badge.svg)](https://github.com/fwcd/swift-minecraft-pi/actions/workflows/linux.yml)

A small library that interfaces with the Minecraft Pi Edition API and lets you place blocks, query the player's position and more in the Minecraft world.

It also provides a great environment for learning how to program Swift on a Raspberry Pi.

## Example

```swift
import MinecraftPi

// Connect to the running Minecraft Pi instance
let mc = try! Minecraft.connect()

// Post a message to the in-game-chat
mc.chat.post("Hello world!")

// Fetch the player's block position
let pos = mc.player.tile

// Place a few blocks
mc.world.setBlock(at: pos + Vec3(x: 10), to: .wood)
mc.world.setBlocks(between: pos + Vec3(x: 11), and: pos + Vec3(x: 14, y: 1), to: .glass)
```
