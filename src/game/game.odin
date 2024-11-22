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
	player: Player,
	enemy:  Enemy,
	lost:   bool,
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
update :: proc(using g: ^Game, delta: time.Duration = 0) {
	update_player(&player, delta)
	update_enemy(&enemy, player, delta)

	g.lost = check_if_lost(g^)
}

move :: proc(e: ^Entity, dir: int, delta: time.Duration) {
	e.pos.x += next_frame_pos_x(dir, e.speed, delta)
}

next_frame_pos_x :: proc(dir: int, speed: int, delta: time.Duration) -> int {
	return dir * int(math.ceil(cast(f64)speed * time.duration_seconds(delta)))
}

// Check lose conditions
check_if_lost :: proc(g: Game) -> bool {
	return g.enemy.pos == g.player.pos
}
