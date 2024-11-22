package main

import "core:fmt"
import "core:time"
import "src:game"
import "src:utils"
import rl "vendor:raylib"

main :: proc() {
	rl.InitWindow(800, 450, "CAT!")
	defer rl.CloseWindow()

	g := &game.Game {
		player = {pos = {200, 250}, speed = 100, jump_height = 60, jump_time = 1 * time.Second},
		enemy = {pos = {500, 250}, min_notice_distance = 100, speed = 50},
		win_zone = {pos = {700, 250}},
	}

	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() && g.state == game.State.InProgress {
		rl.BeginDrawing()
		defer rl.EndDrawing()

		rl.ClearBackground(rl.WHITE)
		rl.DrawRectangle(cast(i32)g.win_zone.pos.x, cast(i32)g.win_zone.pos.y, 100, 100, rl.YELLOW)
		rl.DrawRectangle(cast(i32)g.enemy.pos.x, cast(i32)g.enemy.pos.y, 50, 50, rl.RED)
		rl.DrawRectangle(cast(i32)g.player.pos.x, cast(i32)g.player.pos.y, 25, 25, rl.GREEN)

		switch {
		case rl.IsKeyDown(rl.KeyboardKey.LEFT):
			game.cmd(g, game.Command.MoveLeft)
		case rl.IsKeyDown(rl.KeyboardKey.RIGHT):
			game.cmd(g, game.Command.MoveRight)
		}

		if rl.IsKeyPressed(rl.KeyboardKey.SPACE) {
			game.cmd(g, game.Command.Jump)
		}

		game.update(g, utils.f2s(cast(f64)rl.GetFrameTime()))
	}
}
