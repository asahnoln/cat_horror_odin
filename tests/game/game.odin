package test_game

import "core:testing"
import "src:game"
import rl "vendor:raylib"

@(test)
game_has_default_state :: proc(t: ^testing.T) {
	g := &game.Game{}
	testing.expect_value(t, g.state, game.State.InProgress)
}

@(test)
game_ends_when_enemy_catches_the_player :: proc(t: ^testing.T) {
	g := &game.Game {
		player = {pos = {0, 0}, size = {10, 10}},
		enemy = {pos = {50, 0}, size = {20, 20}},
		win_zone = {pos = {9999, 0}},
	}
	game.update(g)
	testing.expect_value(t, g.state, game.State.InProgress)

	g.enemy.pos.x = 9
	game.update(g)
	testing.expect_value(t, g.state, game.State.Lost)
}

@(test)
game_ends_when_enemy_catches_the_player_vertically :: proc(t: ^testing.T) {
	g := &game.Game {
		player = {pos = {0, -11}, size = {10, 10}},
		enemy = {pos = {0, 0}, size = {20, 20}},
		win_zone = {pos = {9999, 0}},
	}
	game.update(g)
	testing.expect_value(t, g.state, game.State.InProgress)

	g.player.pos.y = -9
	game.update(g)
	testing.expect_value(t, g.state, game.State.Lost)
}

@(test)
game_is_won_when_player_reaches_final_location :: proc(t: ^testing.T) {
	g := &game.Game{player = {pos = {50, 50}}, win_zone = {pos = {50, 50}}}

	game.update(g)
	testing.expect_value(t, g.state, game.State.Won)
}
