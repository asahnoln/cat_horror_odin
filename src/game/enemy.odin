package game

import "core:time"

Enemy :: struct {
	using _:             Entity,
	min_notice_distance: f64,
}

update_enemy :: proc(using e: ^Enemy, p: Player) {
	e.move.x = 0

	if sees(e, p, min_notice_distance) {
		follow(e, p)
	}
}

// If who should follow whom based on minimum notice distance
sees :: proc(using who: Entity, whom: Entity, min_notice_distance: f64) -> bool {
	return abs(pos.x - whom.pos.x) <= min_notice_distance
}

// Who follows Whom
follow :: proc(using who: ^Entity, whom: Entity) {
	if pos.x == whom.pos.x {
		return
	}

	dir: f64 = whom.pos.x < pos.x ? -1 : 1
	set_move_vector_in_dir_with_speed(who, dir)
}
