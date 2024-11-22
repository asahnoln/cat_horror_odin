package test_game

import "core:testing"
import "core:time"
import "src:game"
import rl "vendor:raylib"

@(test)
enemy_follows_player_only_when_notices :: proc(t: ^testing.T) {
	enemy_start_position := game.Pos{50, 0}
	tt := [?]struct {
		player_pos:      game.Pos,
		enemy_final_pos: game.Pos,
	} {
		// When noticed
		{{25, 0}, {48, 0}},
		{{75, 0}, {52, 0}},
		{{50, 0}, {50, 0}},

		// When farther then notice range - enemy stays
		{{24, 0}, {50, 0}},
		{{76, 0}, {50, 0}},
	}

	for test in tt {
		g := &game.Game {
			player = {pos = test.player_pos},
			enemy = {pos = enemy_start_position, min_notice_distance = 25, speed = 4},
		}
		game.update(g, 500 * time.Millisecond)
		testing.expect_value(t, g.enemy.pos.x, test.enemy_final_pos.x)
	}
}
