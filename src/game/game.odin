package game

DEFAULT_SPEED :: 1

Entity :: struct {
	pos: Pos,
}

Game :: struct {
	player: struct {
		using _: Entity,
	},
	enemy:  struct {
		using _: Entity,
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
	g.player.pos.x += dirs[c] * DEFAULT_SPEED
}

play :: proc(g: ^Game) {
	follow(&g.enemy, &g.player)
}

follow :: proc(who, whom: ^Entity) {
	dir := whom.pos.x < who.pos.x ? -1 : 1
	who.pos.x += dir
}
