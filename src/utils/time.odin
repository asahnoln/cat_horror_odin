package utils

import "core:time"

// Convert float seconds to time.Duration seconds
f2s :: proc(t: f64) -> time.Duration {
	return time.Duration(t * f64(time.Second))
}
