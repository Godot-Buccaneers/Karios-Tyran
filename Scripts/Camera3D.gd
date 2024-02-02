@tool
extends Camera3D




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rotationOffset = abs(wrapf(get_parent().get_parent().rotation_degrees.y,-90,90.0))/90.0
	fov = lerpf(fov,lerp(50,75,rotationOffset),delta*2)
	
