@tool
class_name ShipHandler3D extends Node3D



@export var cord : Vector3i : 
	set(value):
		cord = value
		
		position = Vector3(cord*Vector3i(1,1,1)*64)

var shipNode : Node3D = null
var shipScene
@export_enum("Alpha:0","Gamma:1","Omega:2","Omicron:3","Delta:4","Lambda:6","Sigma:9",) var shipSceneID :
	set(value):
		shipSceneID = value
		if shipNode != null : shipNode.queue_free()
		shipScene = load(["res://Models/Destroyer_01.fbx","res://Models/Destroyer_02.fbx","res://Models/Destroyer_03.fbx","res://Models/Frigate_03.fbx","res://Models/Destroyer_05.fbx","res://Models/Light cruiser_01.fbx","res://Models/Light cruiser_02.fbx","res://Models/Light cruiser_03.fbx","res://Models/Light cruiser_04.fbx","res://Models/Light cruiser_05.fbx"][shipSceneID])
		shipNode = await shipScene.instantiate()
		add_child(shipNode)
		shipNode.scale = Vector3.ONE * 1.5
		shipNode.scale.x = .5
		shipNode.position.z = 5
		faceForward = faceForward
		shipTexture = shipTexture

@export var faceForward : bool :
	set(value):
		faceForward = value
		
		if shipNode != null : 
			if faceForward: shipNode.rotation_degrees.y = 90
			else: shipNode.rotation_degrees.y = -90

@export var isClickable:bool = true
@export var canSeeMoves:bool = true

@export var shipTexture : StandardMaterial3D = preload("res://Textures/ShipBaseMesh.tres"):
	set(value):
		shipTexture = value.duplicate(true)
		var shipMesh:MeshInstance3D = shipNode.get_child(0).get_child(0)
		shipMesh.mesh = shipMesh.mesh.duplicate(true)
		shipMesh.mesh.surface_set_material(0,shipTexture)

var area3D:Area3D

signal ship_clicked

signal mouse_entered
signal mouse_exited

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint() and isClickable:
		area3D = Area3D.new()
		await add_child(area3D)
		var collisionShape3D:CollisionShape3D = CollisionShape3D.new()
		area3D.add_child(collisionShape3D)
		collisionShape3D.shape = BoxShape3D.new()
		collisionShape3D.shape.size = Vector3(53,22,48)
		collisionShape3D.position = Vector3.UP * 15
		collisionShape3D.position.z = 5
		collisionShape3D.rotation_degrees = Vector3.UP * 90
		
		area3D.input_event.connect(_on_area_3d_input_event)
		
		area3D.mouse_entered.connect(func():mouse_entered.emit())
		area3D.mouse_exited.connect(func():mouse_exited.emit())
	if canSeeMoves:
		add_child(MouseInArea.new())
		add_child(ClickInfo.new())
		add_child(ShipActionVisualizer.new())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			ship_clicked.emit(self)
			_on_ship_clicked()

func _on_ship_clicked():
	pass
