@tool
class_name ShipActionVisualizer extends Node3D

@export var shipsClickable:bool = true
var visualShips:Array[ShipHandler3D] = [] :
	set(value):
		if value == []:
			for i in visualShips:
				if i != null:
					i.queue_free()
		visualShips = value
	get:
		return visualShips#.filter(func(a:ShipHandler3D):return a != null)
var proccessingClick = false
var toggled : bool = false
@export var tintColor : Color :
	get:
		var parent : ShipHandler3D = get_parent()
		if parent.shipTexture.albedo_texture.load_path == "res://.godot/imported/T_Spase_blue.png-aecb12ecf9a85d10443edd6ef275afa2.s3tc.ctex":
			return Color.BLUE
		else:
			return Color.RED

@onready var classSignal = preload("res://CodeBelt/AnyShipClickedSignal.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	(get_parent() as ShipHandler3D).ship_clicked.connect(_on_ship_clicked)
	classSignal.class_signal.connect(_on_other_ship_clicked)



func _on_other_ship_clicked() : 
	if toggled:
		remove_ships()
	toggled = false
	

func _on_ship_clicked(clickedShip=null):
	if proccessingClick: return 
	proccessingClick = true
	await get_parent().get_child(3).click_stopped
	if not get_parent().get_child(2).mouseInArea : 
		proccessingClick = false
		return
	
	
	if toggled == false : classSignal.class_signal.emit()
	toggled = not toggled
	if toggled:
		if get_parent().shipSceneID == 0: #Alpha
			#centers
			add_ship_ray(Vector3i.RIGHT,1)
			add_ship_ray(Vector3i.LEFT,1)
			add_ship_ray(Vector3i.UP,1)
			add_ship_ray(Vector3i.DOWN,1)
			add_ship_ray(Vector3i.FORWARD,1)
			add_ship_ray(Vector3i.BACK,1)
			
			#corners
			add_ship_ray(Vector3i.UP+Vector3i.FORWARD+Vector3i.RIGHT,1)
			add_ship_ray(Vector3i.DOWN+Vector3i.FORWARD+Vector3i.RIGHT,1)
			add_ship_ray(Vector3i.UP+Vector3i.FORWARD+Vector3i.LEFT,1)
			add_ship_ray(Vector3i.DOWN+Vector3i.FORWARD+Vector3i.LEFT,1)
			add_ship_ray(Vector3i.UP+Vector3i.BACK+Vector3i.RIGHT,1)
			add_ship_ray(Vector3i.DOWN+Vector3i.BACK+Vector3i.RIGHT,1)
			add_ship_ray(Vector3i.UP+Vector3i.BACK+Vector3i.LEFT,1)
			add_ship_ray(Vector3i.DOWN+Vector3i.BACK+Vector3i.LEFT,1)
			
			#edges
			add_ship_ray(Vector3i.RIGHT+Vector3i.FORWARD,1)
			add_ship_ray(Vector3i.LEFT+Vector3i.FORWARD,1)
			add_ship_ray(Vector3i.RIGHT+Vector3i.BACK,1)
			add_ship_ray(Vector3i.LEFT+Vector3i.BACK,1)
			add_ship_ray(Vector3i.UP+Vector3i.FORWARD,1)
			add_ship_ray(Vector3i.DOWN+Vector3i.FORWARD,1)
			add_ship_ray(Vector3i.UP+Vector3i.BACK,1)
			add_ship_ray(Vector3i.DOWN+Vector3i.BACK,1)
			add_ship_ray(Vector3i.UP+Vector3i.RIGHT,1)
			add_ship_ray(Vector3i.DOWN+Vector3i.RIGHT,1)
			add_ship_ray(Vector3i.UP+Vector3i.LEFT,1)
			add_ship_ray(Vector3i.DOWN+Vector3i.LEFT,1)
			
		elif get_parent().shipSceneID == 1: #Gamma
			add_ship_ray(Vector3i.RIGHT+Vector3i.FORWARD,6)
			add_ship_ray(Vector3i.LEFT+Vector3i.FORWARD,6)
			add_ship_ray(Vector3i.UP,6)
			add_ship_ray(Vector3i.DOWN,6)
			add_ship_ray(Vector3i.RIGHT+Vector3i.BACK,6)
			add_ship_ray(Vector3i.LEFT+Vector3i.BACK,6)
		elif get_parent().shipSceneID == 2: #Omega
			add_ship_ray(Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.LEFT,6)
			add_ship_ray(Vector3i.UP,6)
			add_ship_ray(Vector3i.DOWN,6)
			add_ship_ray(Vector3i.FORWARD,6)
			add_ship_ray(Vector3i.BACK,6)
			add_ship_ray(Vector3i.UP+Vector3i.FORWARD+Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.FORWARD+Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.UP+Vector3i.FORWARD+Vector3i.LEFT,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.FORWARD+Vector3i.LEFT,6)
			add_ship_ray(Vector3i.UP+Vector3i.BACK+Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.BACK+Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.UP+Vector3i.BACK+Vector3i.LEFT,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.BACK+Vector3i.LEFT,6)
			add_ship_ray(Vector3i.RIGHT+Vector3i.FORWARD,6)
			add_ship_ray(Vector3i.LEFT+Vector3i.FORWARD,6)
			add_ship_ray(Vector3i.RIGHT+Vector3i.BACK,6)
			add_ship_ray(Vector3i.LEFT+Vector3i.BACK,6)
			add_ship_ray(Vector3i.UP+Vector3i.FORWARD,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.FORWARD,6)
			add_ship_ray(Vector3i.UP+Vector3i.BACK,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.BACK,6)
			add_ship_ray(Vector3i.UP+Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.UP+Vector3i.LEFT,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.LEFT,6)
		elif get_parent().shipSceneID == 3: #Omicron
			add_ship_ray(Vector3i.FORWARD,1,false)
			add_ship_ray(Vector3i.UP+Vector3i.FORWARD+Vector3i.RIGHT,1,true,true)
			add_ship_ray(Vector3i.DOWN+Vector3i.FORWARD+Vector3i.RIGHT,1,true,true)
			add_ship_ray(Vector3i.UP+Vector3i.FORWARD+Vector3i.LEFT,1,true,true)
			add_ship_ray(Vector3i.DOWN+Vector3i.FORWARD+Vector3i.LEFT,1,true,true)
		elif get_parent().shipSceneID == 4: #Delta
			add_ship_ray(Vector3i.UP+Vector3i.FORWARD,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.FORWARD,6)
			add_ship_ray(Vector3i.UP+Vector3i.LEFT,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.LEFT,6)
			add_ship_ray(Vector3i.UP+Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.UP+Vector3i.BACK,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.BACK,6)
		elif get_parent().shipSceneID == 6: #Lamba
			add_ship_ray(Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.LEFT,6)
			add_ship_ray(Vector3i.UP,6)
			add_ship_ray(Vector3i.DOWN,6)
			add_ship_ray(Vector3i.FORWARD,6)
			add_ship_ray(Vector3i.BACK,6)
		elif get_parent().shipSceneID == 9: #Sigma
			add_ship_ray(Vector3i.UP+Vector3i.FORWARD+Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.FORWARD+Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.UP+Vector3i.FORWARD+Vector3i.LEFT,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.FORWARD+Vector3i.LEFT,6)
			add_ship_ray(Vector3i.UP+Vector3i.BACK+Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.BACK+Vector3i.RIGHT,6)
			add_ship_ray(Vector3i.UP+Vector3i.BACK+Vector3i.LEFT,6)
			add_ship_ray(Vector3i.DOWN+Vector3i.BACK+Vector3i.LEFT,6)
	else:
		await remove_ships()
	
	proccessingClick = false

func add_ship_ray(directionCord,distance,canKill=true,inverted=false):
	for dist in distance:
		var ship = await add_ship()
		ship.cord = directionCord * (dist+1)
		if not ship.visible:
			remove_ship(ship)
			return
		await get_tree().physics_frame
		await get_tree().physics_frame
		await get_tree().physics_frame
		if ship == null or ship.area3D == null:return
		if ship.area3D.has_overlapping_areas():
			if ship.area3D.get_overlapping_areas()[0].get_parent() in get_parent().get_parent().get_children():
				remove_ship(ship)
			elif canKill:
				ship.scale *= 1.5
			else:
				remove_ship(ship)
			
			return
		if inverted and not ship.area3D.has_overlapping_areas():
			remove_ship(ship)
			return
	
func add_ship():
	var visualShip = ShipHandler3D.new()
	visualShip.canSeeMoves = false
	visualShips.append(visualShip) ; get_parent().add_child(visualShip)
	visualShip.add_child(ShipUnvisualizer.new())
	visualShip.shipSceneID = get_parent().shipSceneID
	visualShip.shipTexture = get_parent().shipTexture
	visualShip.faceForward = get_parent().faceForward
	visualShip.shipTexture.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_HASH
	visualShip.shipTexture.albedo_color = tintColor
	visualShip.shipTexture.albedo_color.a = -.2
	visualShip.ship_clicked.connect(move_to_clicked_ship)
	var a = func():
		for i in .7 / FakeDelta.delta:
			await get_tree().physics_frame
			if visualShip == null : return
			visualShip.shipTexture.albedo_color.a = lerp(visualShip.shipTexture.albedo_color.a,1.0, FakeDelta.delta)
	a.call()
	return visualShip

func remove_ship(ship):
	visualShips.pop_at(visualShips.find(ship))
	ship.queue_free()

func remove_ships():
	if visualShips == [] or visualShips[-1] == null: 
		visualShips = []
		return
	for ship in visualShips:
		ship.area3D.queue_free()
	while visualShips[-1].shipTexture.albedo_color.a < .4:
		await get_tree().physics_frame
	while visualShips[-1].shipTexture.albedo_color.a > .0:
		await get_tree().physics_frame
		for ship in visualShips:
			ship.shipTexture.albedo_color.a = lerp(ship.shipTexture.albedo_color.a,-.75, FakeDelta.delta / 2.0)
	for ship in visualShips:
		ship.queue_free()
	visualShips = []

func move_to_clicked_ship(clickedShip):
	if not shipsClickable: return
	remove_ships()
	while visualShips != []:
		await get_tree().physics_frame
	get_parent().cord += clickedShip.cord
	
	toggled = false
