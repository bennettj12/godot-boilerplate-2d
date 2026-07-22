extends Node

var is_paused = false
## Triggers after the game is paused
signal paused
## Triggers before shutting down the game
signal before_quit
## Triggers before resetting the scene
signal before_reset

func _input(event):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()
	if Input.is_action_just_pressed("reset"):
		reset_game()
	if Input.is_action_just_pressed("quit"):
		quit_game()

func toggle_pause():
	get_tree().paused = not is_paused
	is_paused = not is_paused
	paused.emit(is_paused)

func reset_game():
	before_reset.emit()
	get_tree().reload_current_scene()
	
func quit_game():
	before_quit.emit()
	get_tree().quit(0)
