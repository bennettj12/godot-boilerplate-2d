extends CanvasLayer


@onready var label : Label = $Label
var logs : Dictionary[String, Variant] = {}
var full_text := ""
func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and \
	(event as InputEventKey).pressed and \
	(event as InputEventKey).keycode == KEY_F3:
		toggle_visible()
## Show Debug Window
func toggle_visible() -> void:
	visible = not visible

func _process(_delta: float) -> void:
	if not visible: return
	label.text = "FPS: %d\n" % [Engine.get_frames_per_second()] + "----\n" + full_text

func display(key: String, value: Variant) -> void:
	if value == null:
		logs.erase(key)
	else:
		logs[key] = value
	full_text = ""
	for k: String in logs.keys():
		full_text += k + ":   "  + str(logs[k]) + "\n"
	pass
