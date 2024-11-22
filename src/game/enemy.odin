package game

import "core:time"

Enemy :: struct {
	using _:             Entity,
	min_notice_distance: int,
}

update_enemy :: proc(using e: ^Enemy, p: Player, delta: time.Duration = 0) {
	if sees(e, p, min_notice_distance) {
		follow(e, p, delta)
	}
}

// If who should follow whom based on minimum notice distance
sees :: proc(using who: Entity, whom: Entity, min_notice_distance: int) -> bool {
	return abs(pos.x - whom.pos.x) <= min_notice_distance
}

// Who follows Whom
follow :: proc(using who: ^Entity, whom: Entity, delta: time.Duration) {
	if pos.x == whom.pos.x {
		return
	}

	dir := whom.pos.x < pos.x ? -1 : 1
	move(who, dir, delta)
}
