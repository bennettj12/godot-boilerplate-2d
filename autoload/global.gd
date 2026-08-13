### Global storage for enums and constants
extends Node

var paused : bool:
	get():
		return get_tree().paused

## Decays naturally
var trauma := 0.0
