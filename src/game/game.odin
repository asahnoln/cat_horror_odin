package game

import "core:time"

DEFAULT_SPEED :: 1

// Any entity having coordinates
Entity :: struct {
	pos: Pos,
}

// Main state object for the game holding all info on current game
Game :: struct {
	player:       struct {
		using _:         Entity,
		jump_height:     int,
		jump_time:       time.Duration,
		jump_start_time: time.Duration,
		jumping:         bool,
	},
	enemy:        struct {
		using _:             Entity,
		min_notice_distance: int,
	},
	time_elapsed: time.Duration,
	lost:         bool,
}

// 2d coordinates
Pos :: distinct [2]int

// Game commands
Command :: enum {
	MoveLeft,
	MoveRight,
	Jump,
}

// Commands mapped to vector directions
dirs := #partial [Command]int {
	.MoveLeft  = -1,
	.MoveRight = 1,
}

// Send command to the Game
cmd :: proc(g: ^Game, c: Command) {
	if c == .Jump {
		g.player.pos.y -= g.player.jump_height
		g.player.jump_start_time = g.time_elapsed
		g.player.jumping = true
	}

	g.player.pos.x += dirs[c] * DEFAULT_SPEED
}

// Play one cycle of the Game
play :: proc(g: ^Game, delta: time.Duration = 0) {
	g.time_elapsed += delta

	if g.player.jumping && g.time_elapsed >= g.player.jump_start_time + g.player.jump_time {
		g.player.pos.y += g.player.jump_height
		g.player.jumping = false
	}

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
