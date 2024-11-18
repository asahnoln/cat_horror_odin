package g2d

import "src:game/rules/cat"

move :: proc(c: ^cat.Cat, x: i32) {
	c.pos.x += x
}
