package test_game

import "core:log"
import "core:testing"
import "core:time"
import "src:game"
import rl "vendor:raylib"

@(test)
player_moves_on_commands :: proc(t: ^testing.T) {
	tests := [?]struct {
		start_pos: game.Vec2,
		c:         game.Command,
		final_pos: game.Vec2,
		speed:     game.Unit,
	} {
		{{0, 0}, game.Command.MoveLeft, {-1, 0}, 2},
		{{100, 200}, game.Command.MoveRight, {102, 200}, 4},
		{{50, 10}, game.Command.MoveLeft, {49.5, 10}, 1},
	}

	for tt in tests {
		g := &game.Game{player = {pos = tt.start_pos, speed = tt.speed}}
		game.cmd(g, tt.c)
		game.update(g, 500 * time.Millisecond)
		testing.expect_value(t, g.player.pos.x, tt.final_pos.x)
	}
}

@(test)
player_stands_when_no_command_passed :: proc(t: ^testing.T) {
	g := &game.Game{player = {speed = 1}}
	game.cmd(g, game.Command.MoveLeft)
	game.update(g, 1 * time.Second)
	testing.expect_value(t, g.player.pos.x, -1)

	game.update(g, 1 * time.Second)
	testing.expect_value(t, g.player.pos.x, -1)
}

// @(test)
player_cannot_jump_while_jump :: proc(t: ^testing.T) {
	g := &game.Game{player = {jump_height = 20}}
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
	g := &game.Game {
		gravity_acceleration = 5,
		player = {pos = {0, 1000}, size = {10, 10}, jump_speed = 25},
		objects = {{pos = {-100, 1010}, size = {200, 200}, blocking = true}},
	}

	game.cmd(g, game.Command.Jump)
	game.update(g, 0)
	testing.expect_value(t, g.player.pos.y, 1000)

	ys := [?]game.Unit{980, 965, 955, 950, 950, 955, 965, 980, 1000, 1000}

	for y in ys {
		game.update(g, 1 * time.Second)
		testing.expect_value(t, g.player.pos.y, y)
	}
}

@(test)
player_dont_go_under_blockin_object :: proc(t: ^testing.T) {
	g := &game.Game {
		gravity_acceleration = 10,
		player = {pos = {0, 190}, size = {10, 10}, jump_speed = 20},
		objects = {{pos = {-100, 210}, size = {200, 200}, blocking = true}},
	}

	game.update(g, 2 * time.Second)
	testing.expect_value(t, g.player.pos.y, 200)
}
