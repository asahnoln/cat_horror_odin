package main

import "src:game"
import rl "vendor:raylib"

drawRec :: proc(r: ^rl.Rectangle, pos: game.Vec2, c: rl.Color) {
	r.x = pos.x
	r.y = pos.y
	rl.DrawRectangleRec(r^, c)
}
