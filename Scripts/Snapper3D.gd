@tool
extends Node3D

@export var cord : Vector3i : 
	set(value):
		cord = value
		
		position = Vector3(cord*Vector3i(1,1,2)*snapRatio)

@export var snapRatio : int = 64:
	set(value):
		snapRatio = value
		cord = cord
