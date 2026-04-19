extends Node

func device_input_map(deviceId: String):
	return {
		"move_left_"+ deviceId: {
			"joy": JOY_BUTTON_DPAD_LEFT,
			"joy-motion": [JOY_AXIS_LEFT_X, -1.0]
		},
		"move_right_" + deviceId: {
			"joy":JOY_BUTTON_DPAD_RIGHT,
			"joy-motion": [JOY_AXIS_LEFT_X, 1.0]
		},
		"move_up_" + deviceId: {
			"joy": JOY_BUTTON_DPAD_UP,
			"joy-motion": [JOY_AXIS_LEFT_Y, -1.0]
		},
		"move_down_" + deviceId: {
			"joy": JOY_BUTTON_DPAD_DOWN,
			"joy-motion": [JOY_AXIS_LEFT_Y, 1.0]
		}
	}
	
func device_inputs(deviceId: String):
	return {
		"move_left": "move_left_"+ deviceId,
		"move_right": "move_right_" + deviceId,
		"move_up": "move_up_" + deviceId,
		"move_down": "move_down_" + deviceId,
	}
