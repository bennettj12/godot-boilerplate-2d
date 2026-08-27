## Contains a collection of players, cycling to allow for polyphony
## Unlike max_polyphony, it does allow you to change the stream between `play()` calls
class_name AudioPlayerCluster
extends Node

@export_range(1,16) var num_channels := 4
@export var bus := &"SFX"
@export var stream : AudioStream
var players : Array[AudioStreamPlayer] = []
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
	var player : AudioStreamPlayer = players[next]
	player.bus = bus
	player.stream = s
	player.volume_db = volume_db
	player.pitch_scale = pitch_scale
	player.play()
	next = (next + 1) % num_channels


func _build_players() -> void:
	for _i: int in num_channels:
		var new_player := AudioStreamPlayer.new()
		add_child(new_player)
		players.append(new_player)
