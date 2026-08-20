extends Node

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle_pause()
	if Input.is_action_just_pressed("reset"):
		reset_game()
	if Input.is_action_just_pressed("quit"):
		quit_game()

func toggle_pause() -> void:
	get_tree().paused = not get_tree().paused

func reset_game() -> void:
	get_tree().reload_current_scene()
	
func quit_game() -> void:
	get_tree().quit(0)
