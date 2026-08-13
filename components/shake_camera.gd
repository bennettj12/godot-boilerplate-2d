class_name ShakeCamera2D
extends Camera2D

@export var decay := 2.0
@export var max_offset := Vector2(30.0, 30.0)
@export var max_roll := 0.06
var _t : Trauma
func _ready() -> void:
	_t = Trauma.new(decay)
	Events.global_trauma.connect(func(t: float) -> void: _t.add(t))

func _process(delta: float) -> void:
	Debug.display("c_offset", offset)
	_t.process(delta)
	shake()

func shake() -> void:
	var sample := _t.sample2d()
	offset = max_offset * sample
	rotation = max_roll * sample.x
