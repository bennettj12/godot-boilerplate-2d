extends CanvasLayer


@onready var label : Label = $Label
var logs : Dictionary[String, Variant] = {}
var full_text = ""
func _ready():
	hide()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_F3:
		toggle_visible()
		
func toggle_visible():
	visible = not visible
	display("debug visible", visible)


func _process(_delta):
	if not visible: return
	label.text = "FPS: %d\n" % [Engine.get_frames_per_second()] + "----\n" + full_text

func display(key: String, value: Variant):
	if value == null:
		logs.erase(key)
	else:
		logs[key] = value
	full_text = ""
	for k in logs.keys():
		full_text += k + ":	"  + str(logs[k])
	pass
