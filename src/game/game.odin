package game

DEFAULT_SPEED :: 1

// Any entity having coordinates
Entity :: struct {
	pos: Pos,
}

// Main state object for the game holding all info on current game
Game :: struct {
	player: struct {
		using _: Entity,
	},
	enemy:  struct {
		using _: Entity,
	},
	lost:   bool,
}

// 2d coordinates
Pos :: distinct [2]int

// Game commands
Command :: enum {
	MoveLeft,
	MoveRight,
}

// Commands mapped to vector directions
dirs := [Command]int {
	.MoveLeft  = -1,
	.MoveRight = 1,
}

// Send command to the Game
cmd :: proc(g: ^Game, c: Command) {
	g.player.pos.x += dirs[c] * DEFAULT_SPEED
}

// Play one cycle of the Game
play :: proc(g: ^Game) {
	follow(&g.enemy, &g.player)

	g.lost = check_if_lost(g)
}

// Who follows Whom
follow :: proc(who, whom: ^Entity) {
	dir := whom.pos.x < who.pos.x ? -1 : 1
	who.pos.x += dir
}

// Check lose conditions
check_if_lost :: proc(g: ^Game) -> bool {
	return g.enemy.pos.x == g.player.pos.x
}
