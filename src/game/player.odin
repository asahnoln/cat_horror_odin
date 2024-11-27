package game

import "core:log"
import "core:math"
import "core:time"

Player :: struct {
	using _:         Entity,
	jump_height:     int,
	jump_speed:      f64,
	current_command: Command,
}

update_player :: proc(using p: ^Player, delta: time.Duration = 0) {
	p.move.x = dirs[current_command] * p.speed
	player_jump(p, delta)

	current_command = .None
}

player_jump :: proc(using p: ^Player, delta: time.Duration) {
	if current_command == .Jump {
		p.move.y = -jump_speed
	}
}
