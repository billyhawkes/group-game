extends CharacterBody2D

## Init with invalid device id
var deviceId = -1

func _physics_process(delta):
	if (deviceId == -1): return
	var deviceInputs = Globals.device_inputs(str(deviceId))
	var direction = Input.get_vector(deviceInputs["move_left"], deviceInputs["move_right"], deviceInputs["move_up"], deviceInputs["move_down"])
	velocity = direction * 400

	move_and_slide()
	
