package cat

DEFAULT_CAT_LIVES :: 9

Cat :: struct {
	lives:              int,
	accomplished_goals: [dynamic]Goal,
}

Goal :: enum {
	Eat,
}

new :: proc() -> Cat {
	return Cat{lives = DEFAULT_CAT_LIVES}
}

accomplish_goal :: proc(using c: ^Cat, g: Goal) {
	append(&accomplished_goals, g)
}
