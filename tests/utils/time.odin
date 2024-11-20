package test_utils

import "core:fmt"
import "core:testing"
import "core:time"
import "src:utils"

@(test)
convert_float_seconds :: proc(t: ^testing.T) {
	s := utils.f2s(1.5)
	testing.expect_value(t, s, 1500 * time.Millisecond)
}
