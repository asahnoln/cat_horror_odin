package game

import "rules/cat"

Game :: struct {
	goals_to_win: [dynamic]cat.Goal,
}

is_won :: proc(g: Game) -> bool {
	return false
}
