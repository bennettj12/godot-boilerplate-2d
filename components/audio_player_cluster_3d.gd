class_name AudioPlayerCluster3D
extends Node3D

@export_range(1, 16) var num_channels := 4
@export var bus := &"SFX"
@export var stream : AudioStream
@export var max_distance := 0.0
@export var unit_size := 1.0
@export var max_db := 3.0
@export var panning_strength := 1.0

var players : Array[AudioStreamPlayer3D] = []
var next := 0
var pitch_scale := 1.0
var volume_db : float = 0.0
var volume_linear : float:
	get():
		return db_to_linear(volume_db)
	set(val):
		volume_db = linear_to_db(val)

func play(s: AudioStream = null) -> void:
	if (players.is_empty()):
		_build_players()
	if s == null:
		s = stream
	var player : AudioStreamPlayer3D = players[next]
	player.stream = s
	player.volume_db = volume_db
	player.pitch_scale = pitch_scale
	player.bus = bus
	player.max_distance = max_distance
	player.panning_strength = panning_strength
	player.max_db = max_db
	player.play()
	next = (next + 1) % num_channels


func _build_players() -> void:
	for _i: int in num_channels:
		var new_player := AudioStreamPlayer3D.new()
		add_child(new_player)
		players.append(new_player)
