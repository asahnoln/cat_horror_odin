package main

import "src:game"
import "src:game/rules/cat"
import rl "vendor:raylib"

main :: proc() {
	rl.InitWindow(800, 450, "CAT!")
	defer rl.CloseWindow()

	g := game.Game {
		player = cat.new_cat(),
	}
	g.player.pos = {400, 250}

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		defer rl.EndDrawing()

		rl.ClearBackground(rl.WHITE)
		rl.DrawRectangle(g.player.pos.x, g.player.pos.y, 50, 50, rl.RED)

		switch {
		case rl.IsKeyDown(rl.KeyboardKey.RIGHT):
			g.player.pos.x += 1
		case rl.IsKeyDown(rl.KeyboardKey.LEFT):
			g.player.pos.x -= 1
		}
	}
}
