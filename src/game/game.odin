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
		using _:             Entity,
		min_notice_distance: int,
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
	if should_follow(&g.enemy, &g.player, g.enemy.min_notice_distance) {
		follow(&g.enemy, &g.player)
	}

	g.lost = check_if_lost(g)
}

// If who should follow whom based on minimum notice distance
should_follow :: proc(who, whom: ^Entity, min_notice_distance: int) -> bool {
	return who.pos.x - whom.pos.x <= min_notice_distance
}

// Who follows Whom
follow :: proc(who, whom: ^Entity) {
	if who.pos.x == whom.pos.x {
		return
	}

	who.pos.x += whom.pos.x < who.pos.x ? -1 : 1
}

// Check lose conditions
check_if_lost :: proc(g: ^Game) -> bool {
	return g.enemy.pos.x == g.player.pos.x
}
