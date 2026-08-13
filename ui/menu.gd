class_name Menu
extends Control

var game_started := false

@onready var start_button: Button = %StartButton
@onready var settings_button: Button = %SettingsButton
@onready var quit_button: Button = %QuitButton
@onready var settings_panel: Control = %SettingsPanel
@onready var back_button: Button = %BackButton
@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider


func _ready() -> void:
	if OS.get_name() == "Web":
		quit_button.visible = false
	settings_panel.modulate.a = 0
	
	start_button.pressed.connect(_on_start_pressed)
	settings_button.pressed.connect(_on_settings_toggled)
	quit_button.pressed.connect(_on_quit_pressed)
	back_button.pressed.connect(_on_settings_toggled)

	master_slider.value_changed.connect(_on_master_changed)
	music_slider.value_changed.connect(_on_music_changed)
	sfx_slider.value_changed.connect(_on_sfx_changed)

	master_slider.value = _get_bus_volume(&"Master")
	music_slider.value = _get_bus_volume(&"Music")
	sfx_slider.value = _get_bus_volume(&"SFX")

	open()


func open() -> void:
	show()
	get_tree().paused = true
	start_button.text = "Resume" if game_started else "Start"

func close() -> void:
	hide()
	get_tree().paused = false


func _on_start_pressed() -> void:
	game_started = true
	close()


func _on_settings_toggled() -> void:
	var on := not settings_panel.visible
	if on:
		settings_panel.visible = on
		create_tween().tween_property(settings_panel, "modulate:a", 1.0, 0.1)
	else:
		var t := create_tween()
		t.tween_property(settings_panel, "modulate:a", 0.0, 0.1)
		t.finished.connect(func() -> void: settings_panel.visible = on)


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_master_changed(value: float) -> void:
	_set_bus_volume(&"Master", value)


func _on_music_changed(value: float) -> void:
	_set_bus_volume(&"Music", value)


func _on_sfx_changed(value: float) -> void:
	_set_bus_volume(&"SFX", value)


# Audio helpers

func _get_bus_volume(bus: StringName) -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus)))


func _set_bus_volume(bus: StringName, value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), linear_to_db(value))
