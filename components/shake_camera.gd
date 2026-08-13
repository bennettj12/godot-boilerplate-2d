class_name ShakeCamera2D
extends Camera2D

var trauma: float = 0
@export var decay := 2.0
@export var max_offset := Vector2(30.0, 30.0)
@export var max_roll := 0.06
@export var noise: Noise
var noise_y: float = 0

func _ready() -> void:
	if noise == null:
		noise = FastNoiseLite.new()
		noise.noise_type = NoiseType.TYPE_VALUE
	Events.trauma.connect(func(t: float) -> void: add_trauma(t))

func add_trauma(amount: float) -> void:
	trauma = clampf(trauma + amount, 0, 1.0)
	
func _process(delta: float) -> void:
	if trauma > 0.0:
		trauma = max(trauma - decay * delta, 0.0)
		shake()

func shake() -> void:
	var shake_amount: float = trauma * trauma
	noise_y += 1
	offset.x = max_offset.x * shake_amount * noise.get_noise_2d(noise_y, 0)
	offset.y = max_offset.y * shake_amount * noise.get_noise_2d(0, noise_y)
	rotation = max_roll * shake_amount * noise.get_noise_2d(noise_y, noise_y)