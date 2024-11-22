package game

import "core:time"

Player :: struct {
	using _:         Entity,
	jump_height:     int,
	jump_time:       time.Duration,
	jump_time_left:  time.Duration,
	current_command: Command,
}

update_player :: proc(using p: ^Player, delta: time.Duration = 0) {
	move(p, dirs[current_command], delta)

	player_jump(p)
	player_jump_reset(p, delta)

	current_command = .None
}

player_jump :: proc(using p: ^Player) {
	if current_command == .Jump && jump_time_left <= 0 {
		pos.y -= jump_height
		jump_time_left = jump_time
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
