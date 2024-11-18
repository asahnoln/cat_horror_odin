package test_rules

import "core:container/queue"
import "core:testing"
import "src:game"
import "src:game/rules/cat"

@(test)
game_is_not_won :: proc(t: ^testing.T) {
	g := game.Game {
		goals_to_win = [dynamic]cat.Goal{cat.Goal.Eat},
	}
	defer delete(g.goals_to_win)

	testing.expect_value(t, game.is_won(g), false)
}
// game_is_won :: proc(t: ^testing.T) {
// 	g := game.new()
// 	c := cat.new()
// 	cat.accomplish_goal(&c, cat.Goal.Eat)
//
// 	g.goals_to_win = [dynamic]cat.Goal{cat.Goal.Eat}
// 	testing.expect_value(t, g.is_won(), true)
// }
