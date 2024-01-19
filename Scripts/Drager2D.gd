extends Node2D

var xOffset = 0
var yOffset = 0

var dragReady:bool = false

func _input(event):
	
	if event is InputEventScreenDrag:
		xOffset += event.velocity.x * .002
		yOffset += event.velocity.y * .002
	
	
	elif event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			global_position = get_global_mouse_position()
			dragReady = true
		else:
			dragReady = false
	elif event is InputEventMouseMotion and dragReady:
		xOffset += get_local_mouse_position().x * .3
		yOffset += get_local_mouse_position().y * .3
		global_position = get_global_mouse_position()


func _physics_process(delta):
	$"../../../..".rotation_degrees.y = lerpf($"../../../..".rotation_degrees.y,-xOffset,delta*2)
	$"../../..".rotation_degrees.z = lerpf($"../../..".rotation_degrees.z,-yOffset,delta*2)
