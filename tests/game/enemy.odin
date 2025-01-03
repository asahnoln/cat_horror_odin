package test_game

import "core:testing"
import "core:time"
import "src:game"
import rl "vendor:raylib"

@(test)
enemy_follows_player_only_when_notices :: proc(t: ^testing.T) {
	enemy_start_position := game.Vec2{50, 0}
	tests := [?]struct {
		player_pos:      game.Vec2,
		enemy_final_pos: game.Vec2,
	} {
		// When noticed
		{{25, 0}, {48, 0}},
		{{75, 0}, {52, 0}},
		{{50, 0}, {50, 0}},

		// When farther then notice range - enemy stays
		{{24, 0}, {50, 0}},
		{{76, 0}, {50, 0}},
	}

	for tt in tests {
		g := &game.Game {
			player = {pos = tt.player_pos},
			enemy = {pos = enemy_start_position, min_notice_distance = 25, speed = 4},
		}
		game.update(g, 500 * time.Millisecond)
		testing.expect_value(t, g.enemy.pos.x, tt.enemy_final_pos.x)
	}
}

@(test)
enemy_stops_following_player_after_he_followed_him :: proc(t: ^testing.T) {
	g := &game.Game {
		player = {pos = {100, 0}},
		enemy = {pos = {110, 0}, min_notice_distance = 15, speed = 5},
	}
	game.update(g, 500 * time.Millisecond)
	testing.expect_value(t, g.enemy.pos.x, 107.5)

	g.player.pos.x = -9999
	game.update(g, 500 * time.Millisecond)
	testing.expect_value(t, g.enemy.pos.x, 107.5)
}
