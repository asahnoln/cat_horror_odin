package utils

import "core:time"

// Convert float seconds to time.Duration seconds
f2s :: proc(t: f32) -> time.Duration {
	return time.Duration(t * f32(time.Second))
}
