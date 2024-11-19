package game

DEFAULT_SPEED :: 1

Game :: struct {
	player: struct {
		pos: Pos,
	},
}

Pos :: distinct [2]i32

Command :: enum {
	MoveLeft,
	MoveRight,
}

dirs := [Command]i32 {
	.MoveLeft  = -1,
	.MoveRight = 1,
}

cmd :: proc(g: ^Game, c: Command) {
	g.player.pos.x = g.player.pos.x + dirs[c] * DEFAULT_SPEED
}
