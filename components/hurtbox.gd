## Hurtboxes are on collision layer 8
class_name Hurtbox
extends Area2D

## Which Health is damaged when this hurtbox is hit:
@export var health : Health

func _ready() -> void:
	collision_layer = 128
	collision_mask = 0

func take_damage(amount: int) -> void:
	if health:
		health.damage(amount)
