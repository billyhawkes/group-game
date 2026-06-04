package main

import rl "vendor:raylib"

Vec2 :: [2]f32

Entity :: struct {
	pos:     Vec2,
	process: proc(e: ^Entity),
}

entities: [dynamic]Entity

MAX_PLAYERS: int : 8

setup :: proc() {
	for i in 0 ..< MAX_PLAYERS {


	}
	player := create_player()

	append(&entities, player)
}

main :: proc() {
	rl.InitWindow(1280, 720, "Cool game")

	setup()
	defer delete(entities)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.WHITE)

		for &e in entities {
			e.process(&e)
		}

		rl.EndDrawing()
	}

	rl.CloseWindow()
}
