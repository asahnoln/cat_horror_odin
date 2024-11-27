package game

import "core:log"
import "core:math"
import "core:math/linalg"
import "core:math/linalg/glsl"
import "core:time"

// Any entity having coordinates
Entity :: struct {
	pos:      Vec2,
	speed:    f64,
	size:     Vec2,
	blocking: bool,
	move:     Vec2,
}

// Main state object for the game holding all info on current game
Game :: struct {
	player:               Player,
	enemy:                Enemy,
	win_zone:             Entity,
	objects:              []Entity,
	state:                State,
	gravity_acceleration: f64,
}

// Game state
State :: enum {
	InProgress,
	Lost,
	Won,
}

// 2d coordinates
Vec2 :: linalg.Vector2f64

// Game commands
Command :: enum {
	None,
	MoveLeft,
	MoveRight,
	Jump,
}

// Commands mapped to vector directions
dirs := #partial [Command]f64 {
	.MoveLeft  = -1,
	.MoveRight = 1,
}

// Send command to the Game
cmd :: proc(using g: ^Game, c: Command) {
	player.current_command = c
}

// Play one cycle of the Game
update :: proc(using g: ^Game, delta: time.Duration = 0) {
	update_gravity(g, delta)
	update_player(&player, delta)
	update_enemy(&enemy, player, delta)
	update_player_collision_with_objects(&player, objects)
	update_state(g)

	player.pos = get_new_pos_with_delta(player.pos, player.move, delta)
}

// Thinking of future gravity for all objects
update_gravity :: proc(g: ^Game, delta: time.Duration) {
	// Update gravity for player only with his jump speed
	g.player.move.y += g.gravity_acceleration
}

update_player_collision_with_objects :: proc(p: ^Player, objs: []Entity) {
	for o in objs {
		if !o.blocking {
			continue
		}

		if collides(p, o) && p.move.y > 0 {
			p.move.y = 0
			// p.pos.y = o.pos.y - p.size.y
		}
	}
}

// Moves entity in direction with its speed
move_entity :: proc(e: ^Entity, dir: Vec2, delta: time.Duration) {
	e.pos = get_new_pos_with_delta(e.pos, dir * e.speed, delta)
}

get_new_pos_with_delta :: proc(pos, dir: Vec2, delta: time.Duration) -> Vec2 {
	return pos + dir * time.duration_seconds(delta)
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
