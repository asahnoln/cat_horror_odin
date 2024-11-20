package test_game

import "core:testing"
import "core:time"
import "src:game"
import rl "vendor:raylib"

@(test)
player_moves_on_commands :: proc(t: ^testing.T) {
	tt := [?]struct {
		start_pos: game.Pos,
		c:         game.Command,
		final_pos: game.Pos,
		speed:     int,
	} {
		{game.Pos{0, 0}, game.Command.MoveLeft, game.Pos{-2, 0}, 2},
		{game.Pos{100, 200}, game.Command.MoveRight, game.Pos{103, 200}, 3},
	}

	for test in tt {
		g := &game.Game{player = {pos = test.start_pos, speed = test.speed}}
		game.cmd(g, test.c)
		testing.expect_value(t, g.player.pos, test.final_pos)
	}
}

@(test)
player_can_jump :: proc(t: ^testing.T) {
	g := &game.Game{player = {jump_height = 10, jump_time = 2 * time.Second}}
	g.player.pos.y = 100

	game.play(g, 1 * time.Second)
	game.cmd(g, game.Command.Jump)
	game.play(g, 0)
	testing.expect_value(t, g.player.pos.y, 90)

	game.play(g, 1 * time.Second)
	game.play(g, 2 * time.Second)
	testing.expect_value(t, g.player.pos.y, 100)

	game.play(g, 2 * time.Second)
	testing.expect_value(t, g.player.pos.y, 100)
}
