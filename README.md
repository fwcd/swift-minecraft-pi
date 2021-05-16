# Minecraft Pi API for Swift

[![Build](https://github.com/fwcd/swift-minecraft-pi/actions/workflows/linux.yml/badge.svg)](https://github.com/fwcd/swift-minecraft-pi/actions/workflows/linux.yml)

A small library that interfaces with the Minecraft Pi Edition API, letting you place blocks, query the player's position and more in a running world.

It also provides a great environment for learning to program Swift on a Raspberry Pi.

## Example

```swift
import MinecraftPi

let mc = try! Minecraft.connect()

mc.chat.post("Hello world!")
```
