### Generic SFX player for non-positional sound effects.
extends Node


const MAX_PLAYERS := 8
var players: Array[AudioStreamPlayer] = []
var next := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for _i in MAX_PLAYERS:
		var player := AudioStreamPlayer.new()
		player.bus = &"SFX"
		add_child(player)
		players.append(player)

func play(stream: AudioStream, volume_db := 0.0, pitch_scale := 1.0) -> void:
	var player := players[next]
	player.volume_db = volume_db
	player.pitch_scale = pitch_scale
	player.stream = stream
	player.play()
	next = (next + 1) % MAX_PLAYERS
