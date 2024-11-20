package main

import "core:fmt"
import "src:game"
import rl "vendor:raylib"

main :: proc() {
	rl.InitWindow(800, 450, "CAT!")
	defer rl.CloseWindow()

	g := &game.Game {
		player = {pos = game.Pos{200, 250}},
		enemy = {pos = game.Pos{700, 250}, min_notice_distance = 100},
	}

	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() && !g.lost {
		rl.BeginDrawing()
		defer rl.EndDrawing()

		rl.ClearBackground(rl.WHITE)
		rl.DrawRectangle(cast(i32)g.enemy.pos.x, cast(i32)g.enemy.pos.y, 50, 50, rl.RED)
		rl.DrawRectangle(cast(i32)g.player.pos.x, cast(i32)g.player.pos.y, 25, 25, rl.GREEN)

		switch {
		case rl.IsKeyDown(rl.KeyboardKey.LEFT):
			game.cmd(g, game.Command.MoveLeft)
		case rl.IsKeyDown(rl.KeyboardKey.RIGHT):
			game.cmd(g, game.Command.MoveRight)
		}

		game.play(g)
	}
}
