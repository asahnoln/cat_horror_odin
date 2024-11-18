package test_2d

import "core:testing"
import "src:game"
import "src:game/g2d"
import "src:game/rules/cat"
import rl "vendor:raylib"

@(test)
cat_moves :: proc(t: ^testing.T) {
	c := cat.new_cat()
	defer free(c)

	g2d.move(c, -1)

	testing.expect_value(t, c.pos.x, -1)
}

@(test)
cat_is_moved_by_keys :: proc(t: ^testing.T) {
	c := cat.new_cat()
	defer free(c)

	g := game.Game {
		player = c,
	}

	game.press(g, rl.KeyboardKey.RIGHT)
	testing.expect_value(t, c.pos.x, 1)

	game.press(g, rl.KeyboardKey.LEFT)
	testing.expect_value(t, c.pos.x, 0)

	game.press(g, rl.KeyboardKey.SPACE)
	testing.expect_value(t, c.pos.x, 0)
}
