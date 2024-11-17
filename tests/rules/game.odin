package test_rules

import "core:testing"

@(test)
game_is_not_won :: proc(t: ^testing.T) {
	g := game.new()
	g.goals_to_win = [dynamic]cat.Goal{cat.Goal.Eat}

	testing.expect_value(t, g.is_won(), false)
}
// game_is_won :: proc(t: ^testing.T) {
// 	g := game.new()
// 	c := cat.new()
// 	cat.accomplish_goal(&c, cat.Goal.Eat)
//
// 	g.goals_to_win = [dynamic]cat.Goal{cat.Goal.Eat}
// 	testing.expect_value(t, g.is_won(), true)
// }
