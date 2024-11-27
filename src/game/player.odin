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
	current_command:    Command,
}

update_player :: proc(using p: ^Player, delta: time.Duration = 0) {
	move(p, dirs[current_command], delta)
	player_jump(p, delta)

	current_command = .None
}

player_jump :: proc(using p: ^Player, delta: time.Duration) {
	if current_command == .Jump {
		jump_current_speed = jump_speed
	}
}
