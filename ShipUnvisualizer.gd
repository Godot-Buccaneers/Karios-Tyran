@tool
class_name ShipUnvisualizer extends Node3D

# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent() is ShipHandler3D:
		if get_parent().get_parent() is ShipHandler3D:
			if not (get_parent().get_parent().cord.x + get_parent().cord.x) in range(-3,3+1):
				get_parent().visible = false
			elif not get_parent().get_parent().cord.z + get_parent().cord.z in range(-8,1):
				get_parent().visible = false
			elif not get_parent().get_parent().cord.y + get_parent().cord.y in range(1,7+1):
				get_parent().visible = false
			else:
				get_parent().visible = true
		else:
			if not get_parent().cord.x in range(-3,3+1):
				get_parent().visible = false
			elif not get_parent().cord.z in range(-8,1):
				get_parent().visible = false
			elif not get_parent().cord.y in range(1,7+1):
				get_parent().visible = false
			else:
				get_parent().visible = true
