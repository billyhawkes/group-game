extends Node2D

var players = {}

func _input(event):
	var deviceId = event.device
	print(deviceId)

	## Check to see that that event id on an action
	if not players.get(deviceId) and event.is_action_pressed("start"):

		## create the player scene instance
		var playerScene = preload("res://player.tscn")
		var player = playerScene.instantiate()

		## give it a name so it's unique, if you really want
		player.set_name('player-' + str(deviceId))

		## Give the player instance a device id so it can handle its own events
		player.deviceId = deviceId
		## register the player in the players dict
		players[deviceId] = player
		
		## Create input map
		var deviceInputMap = Globals.device_input_map(str(deviceId))
		for action in deviceInputMap:
			InputMap.add_action(action)
			var joyAction = deviceInputMap[action]["joy"]
			if joyAction:
				var e = InputEventJoypadButton.new()
				e.device = deviceId
				e.button_index = joyAction
				InputMap.action_add_event(action, e)
			var joyMotion = deviceInputMap[action]["joy-motion"]
			if joyAction:
				var e = InputEventJoypadMotion.new()
				e.device = deviceId
				e.axis = joyMotion[0]
				e.axis_value = joyMotion[1]
				InputMap.action_add_event(action, e)
			

		## Add the player to the scene
		add_child(player)
