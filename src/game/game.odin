package game

import "core:math"
import "core:time"

// Any entity having coordinates
Entity :: struct {
	pos:   Pos,
	speed: int,
	size:  Size,
}

// Main state object for the game holding all info on current game
Game :: struct {
	player:   Player,
	enemy:    Enemy,
	win_zone: Entity,
	state:    State,
}

// Game state
State :: enum {
	InProgress,
	Lost,
	Won,
}

// 2d coordinates
Pos :: distinct [2]int

// 2d size
Size :: distinct [2]int

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
	update_state(g)
}

// Moves entity in direction with its speed
move :: proc(e: ^Entity, dir: int, delta: time.Duration) {
	e.pos.x += next_frame_pos_x(dir, e.speed, delta)
}

// Calculate next x coordinate in delta time
next_frame_pos_x :: proc(dir: int, speed: int, delta: time.Duration) -> int {
	return dir * int(math.ceil(cast(f64)speed * time.duration_seconds(delta)))
}

// Check win/lose conditions
update_state :: proc(using g: ^Game) {
	switch {
	case collides(g.enemy, g.player):
		state = .Lost
	case inside(g.player, g.win_zone):
		state = .Won
	}
}

// Who collides with Whom
collides :: proc(who, whom: Entity) -> bool {
	return(
		(who.pos.x <= whom.pos.x + whom.size.x && who.pos.x >= whom.pos.x ||
			who.pos.x + who.size.x >= whom.pos.x &&
				who.pos.x + who.size.x <= whom.pos.x + whom.size.x) &&
		(who.pos.y <= whom.pos.y + whom.size.y && who.pos.y >= whom.pos.y ||
				who.pos.y + who.size.y >= whom.pos.y &&
					who.pos.y + who.size.y <= whom.pos.y + whom.size.y) \
	)
}

// Who is fully inside Whom or fully covers Whom
inside :: proc(who, whom: Entity) -> bool {
	return inside_final(who, whom) || inside_final(whom, who)
}

@(private)
inside_final :: proc(who, whom: Entity) -> bool {
	return(
		(who.pos.x >= whom.pos.x &&
			who.pos.x + who.size.x <= whom.pos.x + whom.size.x &&
			who.pos.y >= whom.pos.y &&
			who.pos.y + who.size.y <= whom.pos.y + whom.size.y) \
	)
}
