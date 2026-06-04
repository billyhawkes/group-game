package main

import "core:fmt"
import rl "vendor:raylib"

Vec2 :: [2]f32

Entity :: union {
	Player,
}

entities: [dynamic]Entity


global_update :: proc() {
	update_player()
}


main :: proc() {
	rl.InitWindow(1280, 720, "Cool game")
	rl.SetTargetFPS(60)

	defer delete(entities)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.WHITE)

		global_update()

		for &e in entities {
			switch &t in e {
			case Player:
				t.update(&t)
			}
		}

		rl.EndDrawing()
	}

	rl.CloseWindow()
}
