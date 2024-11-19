package game

DEFAULT_SPEED :: 1

Game :: struct {
	player: struct {
		pos: Pos,
	},
	enemy:  struct {
		pos: Pos,
	},
}

Pos :: distinct [2]int

Command :: enum {
	MoveLeft,
	MoveRight,
}

dirs := [Command]int {
	.MoveLeft  = -1,
	.MoveRight = 1,
}

cmd :: proc(g: ^Game, c: Command) {
	g.player.pos.x = g.player.pos.x + dirs[c] * DEFAULT_SPEED
}

play :: proc(g: ^Game) {
	dir := g.player.pos.x < g.enemy.pos.x ? -1 : 1
	g.enemy.pos.x = g.enemy.pos.x + dir
}
