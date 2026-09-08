## Generic persistent storage
extends Node

const PATH := "user://store.json"

var _data : Dictionary = {}

func _ready() -> void:
	if FileAccess.file_exists(PATH):
		_data = JSON.parse_string(FileAccess.get_file_as_string(PATH))

func get_value(key: String, default: Variant = null) -> Variant:
	return _data.get(key, default)

func set_value(key: String, value: Variant) -> bool:
	_data[key] = value
	return FileAccess.open(PATH, FileAccess.WRITE).store_string(JSON.stringify(_data, "\t"))
