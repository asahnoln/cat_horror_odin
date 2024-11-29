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
		gravity_acceleration = 700,
		player = {pos = {200, 0}, speed = 200, jump_speed = 400, size = {25, 25}},
		enemy = {pos = {500, 200}, min_notice_distance = 200, speed = 130, size = {50, 50}},
		win_zone = {pos = {700, 150}, size = {100, 100}},
		objects = {
			{pos = {-500, 250}, size = {2000, 1000}, blocking = true},
			{pos = {200, 150}, size = {30, 5}, blocking = true},
			{pos = {400, 180}, size = {30, 5}, blocking = true},
			{pos = {600, 170}, size = {30, 5}, blocking = true},
		},
	}

	c := rl.Camera2D{}
	c.offset = {800 / 2, 450 / 2}
	c.target = {400, 250}
	c.zoom = 1

	// NOTE: Should not fix fps I guess
	rl.SetTargetFPS(60)

	objs := make([]rl.Rectangle, len(g.objects))
	for o, i in g.objects {
		objs[i] = rl.Rectangle {
			x      = o.pos.x,
			y      = o.pos.y,
			width  = o.size.x,
			height = o.size.y,
		}
	}

	w := rl.Rectangle {
		x      = g.win_zone.pos.x,
		y      = g.win_zone.pos.y,
		width  = g.win_zone.size.x,
		height = g.win_zone.size.y,
	}
	e := rl.Rectangle {
		x      = g.enemy.pos.x,
		y      = g.enemy.pos.y,
		width  = g.enemy.size.x,
		height = g.enemy.size.y,
	}
	p := rl.Rectangle {
		x      = g.player.pos.x,
		y      = g.player.pos.y,
		width  = g.player.size.x,
		height = g.player.size.y,
	}
	for !rl.WindowShouldClose() && g.state == game.State.InProgress {
		c.target = g.player.pos

		rl.BeginDrawing()
		defer rl.EndDrawing()

		rl.ClearBackground(rl.WHITE)

		rl.BeginMode2D(c)

		for o in objs {
			rl.DrawRectangleRec(o, rl.GRAY)
		}

		drawRec(&w, g.win_zone.pos, rl.YELLOW)
		drawRec(&e, g.enemy.pos, rl.RED)
		drawRec(&p, g.player.pos, rl.GREEN)

		rl.EndMode2D()

		switch {
		case rl.IsKeyDown(rl.KeyboardKey.LEFT):
			game.cmd(g, game.Command.MoveLeft)
		case rl.IsKeyDown(rl.KeyboardKey.RIGHT):
			game.cmd(g, game.Command.MoveRight)
		}

		if rl.IsKeyPressed(rl.KeyboardKey.SPACE) {
			game.cmd(g, game.Command.Jump)
		}

		game.update(g, utils.f2s(rl.GetFrameTime()))
	}
}
