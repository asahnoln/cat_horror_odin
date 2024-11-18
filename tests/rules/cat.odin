package test_rules

import "core:testing"
import "src:game/rules/cat"

@(test)
cat_has_9_lives :: proc(t: ^testing.T) {
	c := cat.new_cat()
	defer free(c)

	testing.expect_value(t, c.lives, 9)
}

@(test)
cat_can_accomplish_goal :: proc(t: ^testing.T) {
	c := cat.new_cat()
	defer free(c)
	defer delete(c.accomplished_goals)

	cat.accomplish_goal(c, cat.Goal.Eat)
	testing.expect_value(t, c.accomplished_goals[0], cat.Goal.Eat)
}
