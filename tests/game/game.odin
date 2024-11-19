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

@(test)
enemy_follows_player :: proc(t: ^testing.T) {
	tt := [?]struct {
		player_pos:      game.Pos,
		enemy_final_pos: game.Pos,
	}{{game.Pos{0, 0}, game.Pos{49, 0}}, {game.Pos{100, 0}, game.Pos{51, 0}}}

	for test in tt {
		g := &game.Game{player = {pos = test.player_pos}, enemy = {pos = game.Pos{50, 0}}}
		game.play(g)
		testing.expect_value(t, g.enemy.pos.x, test.enemy_final_pos.x)
	}
}

@(test)
game_ends_when_enemy_catches_the_player :: proc(t: ^testing.T) {
	g := &game.Game{player = {pos = game.Pos{0, 0}}, enemy = {pos = game.Pos{1, 0}}}
	testing.expect(t, !g.lost)

	game.play(g)
	testing.expect(t, g.lost)

	// TODO: Does the Game fully stops? Does it register some commands or not?
}
