package main

import "core:fmt"
import rl "vendor:raylib"

SPEED: f32 = 200
MAX_PLAYERS: i32 : 8

Player :: struct {
	id:          i32,
	gamepad:     i32,
	translation: rl.Vector2,
	update:      proc(e: ^Player),
}

create_player := proc(id: i32, gamepad: i32) -> Player {
	player := Player {
		gamepad = gamepad,
		translation = {0, 0},
		update = proc(player: ^Player) {
			dir := rl.Vector2 {
				rl.GetGamepadAxisMovement(player.gamepad, .LEFT_X),
				rl.GetGamepadAxisMovement(player.gamepad, .LEFT_Y),
			}

			dir = rl.Vector2Normalize(dir)

			player.translation.x += dir.x * SPEED * rl.GetFrameTime()
			player.translation.y += dir.y * SPEED * rl.GetFrameTime()

			rl.DrawRectangleV(player.translation, {100, 100}, rl.BLUE)
		},
	}
	return player
}

update_player := proc() {
	for i in 0 ..< MAX_PLAYERS {
		if !rl.IsGamepadAvailable(i) {
			continue
		}

		exists := false
		for &e in entities {
			switch &t in e {
			case Player:
				if t.gamepad == i {
					exists = true
				}
			}
		}
		if exists {continue}

		fmt.println("Registered", i)

		new_player := create_player(i32(len(entities)), i)
		append(&entities, new_player)

	}
}
