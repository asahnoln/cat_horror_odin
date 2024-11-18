package cat

DEFAULT_CAT_LIVES :: 9

Cat :: struct {
	lives:              int,
	accomplished_goals: [dynamic]Goal,
	pos:                [2]i32,
}

Goal :: enum {
	Eat,
}

new_cat :: proc() -> ^Cat {
	c := new(Cat)
	c.lives = DEFAULT_CAT_LIVES

	return c
}

accomplish_goal :: proc(using c: ^Cat, g: Goal) {
	append(&accomplished_goals, g)
}
