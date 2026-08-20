## Hitboxes scan collision layer 8
class_name Hitbox
extends Area2D

@export var power :int = 10
@export var lifetime : float = 0.1 # seconds
## Entity that created the hitbox (so it won't hit its own hurtboxes)
@export var source : Node
@export var permanent : bool = false
## Permanent entities need a way to clear the entities hit array if they should be able
## To hit things more than once.
var entities_hit : Array[Node] = []

@onready var time_remaining := lifetime

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	collision_mask = 128

func _on_area_entered(area: Area2D) -> void:
	if not area is Hurtbox:
		return
	if area.owner == source: 
		return
	if entities_hit.has(area.owner):
		return
	
	(area as Hurtbox).take_damage(power)
	entities_hit.append(area.owner)

func _process(delta: float) -> void:
	if permanent: 
		return
	
	time_remaining -= delta
	if time_remaining <= 0:
		queue_free()
		
