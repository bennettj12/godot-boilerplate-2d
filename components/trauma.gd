class_name Trauma
extends RefCounted
## Rate of decay (Per second)
var _decay: float
## Current value
var trauma: float
var curve: float:
	get():
		return trauma * trauma
var _noise: FastNoiseLite
var _noise_y := 0

var active: bool:
	get():
		return trauma > 0.0

func _init( \
decay: float = 1.0, \
frequency: float = 0.2, \
noise_type: int = FastNoiseLite.TYPE_SIMPLEX) -> void:
	_decay = max(decay, 0.0)
	trauma = 0.0
	_noise = FastNoiseLite.new()
	_noise.noise_type = (noise_type as FastNoiseLite.NoiseType)
	_noise.frequency = frequency

func add(amount: float) -> void:
	trauma = clampf(trauma + amount, 0, 1.0)

func process(delta: float) -> void:
	if trauma > 0.0:
		trauma = max(trauma - _decay * delta, 0.0)

func sample1d() -> float:
	if not active: return 0.0
	_noise_y += 1
	return curve * _noise.get_noise_1d(_noise_y)
func sample2d() -> Vector2:
	if not active: return Vector2.ZERO
	_noise_y += 1
	return Vector2(curve * _noise.get_noise_2d(_noise_y, 0), \
	curve * _noise.get_noise_2d(0, _noise_y) )
