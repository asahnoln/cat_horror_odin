package test_game

import "core:testing"
import "src:game"
import rl "vendor:raylib"

@(test)
game_ends_when_enemy_catches_the_player :: proc(t: ^testing.T) {
	g := &game.Game{player = {pos = game.Pos{0, 0}}, enemy = {pos = game.Pos{1, 0}}}
	game.update(g)
	testing.expect(t, !g.lost)

	g = &game.Game{player = {pos = game.Pos{0, 0}}, enemy = {pos = game.Pos{0, 0}}}
	game.update(g)
	testing.expect(t, g.lost)

	g = &game.Game{player = {pos = game.Pos{0, 10}}, enemy = {pos = game.Pos{0, 0}}}
	game.update(g)
	testing.expect(t, !g.lost)
}
