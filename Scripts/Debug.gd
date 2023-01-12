extends Node2D

func _process(delta):
	$CanvasLayer/Label.text = "State " + str($Player.current_state)
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
