package game

import "core:math"
import "core:time"

// Any entity having coordinates
Entity :: struct {
	pos:   Pos,
	speed: int,
}

// Main state object for the game holding all info on current game
Game :: struct {
	player:       struct {
		using _:         Entity,
		jump_height:     int,
		jump_time:       time.Duration,
		jump_time_left:  time.Duration,
		current_command: Command,
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
	None,
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
	g.player.current_command = c
}

// Play one cycle of the Game
play :: proc(g: ^Game, delta: time.Duration = 0) {
	g.time_elapsed += delta

	player_move(g, delta)
	player_jump(g)
	player_jump_reset(g, delta)
	g.player.current_command = .None

	if should_follow(&g.enemy, &g.player, g.enemy.min_notice_distance) {
		follow(&g.enemy, &g.player, delta)
	}

	g.lost = check_if_lost(g)
}

player_move :: proc(g: ^Game, delta: time.Duration) {
	move(&g.player, dirs[g.player.current_command], delta)
}

player_jump :: proc(g: ^Game) {
	if g.player.current_command == .Jump {
		g.player.pos.y -= g.player.jump_height
		g.player.jump_time_left = g.player.jump_time
	}
}

player_jump_reset :: proc(g: ^Game, delta: time.Duration) {
	if g.player.jump_time_left > 0 {
		g.player.jump_time_left -= delta

		if g.player.jump_time_left <= 0 {
			g.player.pos.y += g.player.jump_height
		}
	}
}

// If who should follow whom based on minimum notice distance
should_follow :: proc(who, whom: ^Entity, min_notice_distance: int) -> bool {
	return who.pos.x - whom.pos.x <= min_notice_distance
}

// Who follows Whom
follow :: proc(who, whom: ^Entity, delta: time.Duration) {
	if who.pos.x == whom.pos.x {
		return
	}

	dir := whom.pos.x < who.pos.x ? -1 : 1
	move(who, dir, delta)
}

move :: proc(e: ^Entity, dir: int, delta: time.Duration) {
	e.pos.x += next_frame_pos_x(dir, e.speed, delta)
}

next_frame_pos_x :: proc(dir: int, speed: int, delta: time.Duration) -> int {
	return dir * int(math.ceil(cast(f64)speed * time.duration_seconds(delta)))
}

// Check lose conditions
check_if_lost :: proc(g: ^Game) -> bool {
	return g.enemy.pos == g.player.pos
}
