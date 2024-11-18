package game

import "g2d"
import "rules/cat"
import "vendor:raylib"

Game :: struct {
	player:       ^cat.Cat,
	goals_to_win: [dynamic]cat.Goal,
}

is_won :: proc(g: Game) -> bool {
	return false
}

press :: proc(g: Game, k: raylib.KeyboardKey) {
	x: i32

	#partial switch k {
	case raylib.KeyboardKey.RIGHT:
		x = 1
	case raylib.KeyboardKey.LEFT:
		x = -1
	}

	g2d.move(g.player, x)
}
