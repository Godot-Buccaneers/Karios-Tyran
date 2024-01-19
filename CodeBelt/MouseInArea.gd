class_name MouseInArea extends Node

@onready var parentNode = get_parent()

var mouseInArea:bool = false
var has_valid_parent:bool :
	get:
		return get_parent().has_signal("mouse_entered") and get_parent().has_signal("mouse_exited")

func _process(delta):
	update_configuration_warnings()

func _ready():
	if has_valid_parent:
		parentNode.mouse_entered.connect(_mouse_entered)
		parentNode.mouse_exited.connect(_mouse_exited)
	else:
		printerr("MouseInArea-Node's Parent Lacks the mouse_entered and mouse_exited signals")

func _mouse_entered():
	mouseInArea = true
func _mouse_exited():
	mouseInArea = false
