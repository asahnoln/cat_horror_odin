package game

import "core:log"
import "core:math"
import "core:time"

Player :: struct {
	using _:            Entity,
	jump_height:        int,
	jump_time:          time.Duration,
	jump_time_left:     time.Duration,
	jump_speed:         int,
	jump_current_speed: int,
	gravity:            bool,
	current_command:    Command,
}

update_player :: proc(using p: ^Player, delta: time.Duration = 0) {
	move(p, dirs[current_command], delta)

	player_jump_with_gravity(p, delta)
	// player_jump_reset(p, delta)

	current_command = .None
}

player_jump_with_gravity :: proc(using p: ^Player, delta: time.Duration) {
	if current_command == .Jump {
		jump_current_speed = jump_speed
		p.gravity = true
	}

	if p.gravity {
		p.pos.y += next_frame_pos(jump_current_speed > 0 ? -1 : 1, jump_current_speed, delta)
		jump_current_speed += next_frame_pos(-1, gravity_acceleration, delta)
	}
}

player_jump_reset :: proc(using p: ^Player, delta: time.Duration) {
	if jump_time_left > 0 {
		jump_time_left -= delta

		if jump_time_left <= 0 {
			pos.y += jump_height
		}
	}
}
