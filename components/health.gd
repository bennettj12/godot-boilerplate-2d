class_name Health
extends Node
## Maximum amount of health
@export var max_health : int = 100
var current_health := max_health
var dead := false

signal died
signal revived
signal damaged
signal healed

func heal(amount : int) -> void:
	if amount <= 0: return
	var amount_healed = min(current_health+amount, max_health) - current_health
	current_health += amount_healed
	healed.emit(amount_healed)
	if current_health > 0 and dead:
		dead = false
		revived.emit()
func damage(amount : int) -> void:
	if amount <= 0: return
	var amount_damaged = current_health - max(current_health - amount, 0)
	current_health -= amount_damaged
	damaged.emit(amount_damaged)
	if current_health <= 0 and not dead:
		died.emit()
		dead = true
