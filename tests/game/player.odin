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
		{game.Pos{0, 0}, game.Command.MoveLeft, game.Pos{-1, 0}, 2},
		{game.Pos{100, 200}, game.Command.MoveRight, game.Pos{102, 200}, 4},
		{game.Pos{50, 10}, game.Command.MoveLeft, game.Pos{49, 10}, 1},
	}

	for test in tt {
		g := &game.Game{player = {pos = test.start_pos, speed = test.speed}}
		game.cmd(g, test.c)
		game.update(g, 500 * time.Millisecond)
		testing.expect_value(t, g.player.pos, test.final_pos)
	}
}

@(test)
player_stands_when_no_command_passed :: proc(t: ^testing.T) {
	g := &game.Game{player = {speed = 1}}
	game.cmd(g, game.Command.MoveLeft)
	game.update(g, 1 * time.Second)
	testing.expect_value(t, g.player.pos, game.Pos{-1, 0})

	game.update(g, 1 * time.Second)
	testing.expect_value(t, g.player.pos, game.Pos{-1, 0})
}

// @(test)
player_cannot_jump_while_jump :: proc(t: ^testing.T) {
	g := &game.Game{player = {jump_height = 20, jump_time = 4 * time.Second}}
	g.player.pos.y = 50

	game.cmd(g, game.Command.Jump)
	game.update(g, 1 * time.Second)

	game.cmd(g, game.Command.Jump)
	game.update(g, 1 * time.Second)
	testing.expect_value(t, g.player.pos.y, 30)

	game.update(g, 10 * time.Second)

	// Second jump to mitigate delta
	game.cmd(g, game.Command.Jump)
	game.update(g, 1 * time.Second)

	game.cmd(g, game.Command.Jump)
	game.update(g, 1 * time.Second)
	testing.expect_value(t, g.player.pos.y, 30)
}

@(test)
player_can_jump_with_gravity :: proc(t: ^testing.T) {
	game.gravity_acceleration = 5
	g := &game.Game{gravity_acceleration = 5, player = {pos = {0, 1000}, jump_speed = 20}}
	g.player.pos.y = 1000

	game.cmd(g, game.Command.Jump)
	game.update(g, 0)
	testing.expect_value(t, g.player.pos.y, 1000)

	game.update(g, 1 * time.Second)
	testing.expect_value(t, g.player.pos.y, 980)

	game.update(g, 1 * time.Second)
	testing.expect_value(t, g.player.pos.y, 965)

	game.update(g, 1 * time.Second)
	testing.expect_value(t, g.player.pos.y, 955)

	game.update(g, 1 * time.Second)
	testing.expect_value(t, g.player.pos.y, 950)

	game.update(g, 1 * time.Second)
	testing.expect_value(t, g.player.pos.y, 955)
	//
	// game.update(g, 1 * time.Second)
	// testing.expect_value(t, g.player.pos.y, 965)
	//
	// game.update(g, 1 * time.Second)
	// testing.expect_value(t, g.player.pos.y, 980)
	//
	// game.update(g, 0)
	// testing.expect_value(t, g.player.pos.y, 1000)
}
