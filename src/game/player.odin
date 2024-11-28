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

update_player :: proc(using p: ^Player) {
	set_move_vector_in_dir_with_speed(p, dirs[current_command])
	player_jump(p)

	current_command = .None
}

player_jump :: proc(using p: ^Player) {
	if current_command == .Jump {
		p.move.y = -jump_speed
	}
}
