package main

import "core:fmt"
import rl "vendor:raylib"

SPEED: f32 = 200
MAX_PLAYERS: i32 : 8

Player :: struct {
	id:          i32,
	gamepad:     i32,
	translation: rl.Vector2,
	update:      proc(e: ^Player, atlas: rl.Texture2D),
}

create_player := proc(id: i32, gamepad: i32) -> Player {
	player := Player {
		gamepad = gamepad,
		translation = {0, 0},
		update = proc(player: ^Player, atlas: rl.Texture2D) {
			dir := rl.Vector2 {
				rl.GetGamepadAxisMovement(player.gamepad, .LEFT_X),
				rl.GetGamepadAxisMovement(player.gamepad, .LEFT_Y),
			}

			// Fallback Player 1
			if player.gamepad == 0 {
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
			}

			// Fallback Player 2
			if player.gamepad == 1 {
				if rl.IsKeyDown(rl.KeyboardKey.UP) {
					dir.y -= 1
				}
				if rl.IsKeyDown(rl.KeyboardKey.DOWN) {
					dir.y += 1
				}
				if rl.IsKeyDown(rl.KeyboardKey.RIGHT) {
					dir.x += 1
				}
				if rl.IsKeyDown(rl.KeyboardKey.LEFT) {
					dir.x -= 1
				}
			}

			dir = rl.Vector2Normalize(dir)

			player.translation.x += dir.x * SPEED * rl.GetFrameTime()
			player.translation.y += dir.y * SPEED * rl.GetFrameTime()

			source := rl.Rectangle{0 + f32(player.gamepad * 80), 0, 80, 80}

			rl.DrawTextureRec(atlas, source, player.translation, rl.WHITE)
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
