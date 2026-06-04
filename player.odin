package main

import rl "vendor:raylib"

SPEED: f32 = 200

create_player := proc() -> Entity {
	player := Entity {
		pos = {0, 0},
		process = proc(e: ^Entity) {
			dir: rl.Vector2 = {0, 0}
			if rl.IsKeyDown(rl.KeyboardKey.W) {
				dir.y -= 1
			}
			if rl.IsKeyDown(rl.KeyboardKey.S) {
				dir.y += 1
			}
			if rl.IsKeyDown(rl.KeyboardKey.D) {
				dir.x += 1
			}
			if rl.IsKeyDown(rl.KeyboardKey.A) {
				dir.x -= 1
			}

			dir = rl.Vector2Normalize(dir)

			e.pos.x += dir.x * SPEED * rl.GetFrameTime()
			e.pos.y += dir.y * SPEED * rl.GetFrameTime()

			rl.DrawRectangleV(e.pos, {100, 100}, rl.BLUE)
		},
	}
	return player
}
