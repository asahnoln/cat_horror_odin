package test_game

import "core:testing"
import "src:game"
import rl "vendor:raylib"

@(test)
player_moves_on_commands :: proc(t: ^testing.T) {
	tt := [?]struct {
		start_pos: game.Pos,
		c:         game.Command,
		final_pos: game.Pos,
	} {
		{game.Pos{0, 0}, game.Command.MoveLeft, game.Pos{-1, 0}},
		{game.Pos{100, 200}, game.Command.MoveRight, game.Pos{101, 200}},
	}

	for test in tt {
		g := &game.Game{player = {pos = test.start_pos}}
		game.cmd(g, test.c)
		testing.expect_value(t, g.player.pos, test.final_pos)
	}
}
