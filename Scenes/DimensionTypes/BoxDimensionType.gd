extends DimensionType

@onready var Floor = $CSGCombiner3D/Floor
@onready var CeilingRemover = $CSGCombiner3D/Floor/CeilingRemover
@onready var Player = $Player
@onready var ObjectSpawner = $ObjectSpawner

func _generate_dimension(seed:int):
	RNG.seed = seed
	var FloorSizeX = RNG.randi_range(20,250)
	var FloorSizeZ = RNG.randi_range(20,250)
	var FloorSizeY = RNG.randi_range(5.0,15.0)
	
	Floor.size.x = FloorSizeX
	Floor.size.z = FloorSizeZ
	
	var HeightDifference: float = FloorSizeY - Floor.size.y
	Floor.size.y = FloorSizeY
	Floor.position.y += HeightDifference/2.0
	CeilingRemover.size.x = FloorSizeX + 10
	CeilingRemover.size.z = FloorSizeZ + 10
	Player.position.y = 2.0
	
	if RNG.randi_range(0,4) == 0:
		CeilingRemover.queue_free()
	
	for i in range(1,RNG.randi_range(2,10)):
		var TreePositionX = RNG.randi_range((-FloorSizeX/2.0)-10,(FloorSizeX/2.0)+10)
		var TreePositionZ = RNG.randi_range((-FloorSizeZ/2.0)-10,(FloorSizeZ/2.0)+10)
		var TreePositionY = 0
		print(Vector3(TreePositionX,TreePositionY,TreePositionZ))
		ObjectSpawner.spawn_object("res://Objects/StaticObjects/Tree/TreeObject.tscn",Vector3(TreePositionX,TreePositionY,TreePositionZ))
		#generate_door(FloorSizeX,HeightDifference/2.0,FloorSizeZ)

	var Materials = pick_random_materials(seed)
	Floor.material = Materials[RNG.randi() % Materials.size()]
	CeilingRemover.material = Materials[RNG.randi() % Materials.size()]
#
#func generate_door(RegionX:int,RegionY:int,RegionZ:int):
	#var DoorNode = DoorScene.instantiate()
	#DoorNode.position.x = RNG.randi_range((-RegionX/2.0)-10,(RegionX/2.0)+10)
	#DoorNode.position.z = RNG.randi_range((-RegionZ/2.0)-10,(RegionZ/2.0)+01)
	#DoorNode.position.y = 0 
	#DoorNode.rotation.y = RNG.randf_range(-360,360)
	#DoorNode.seed = RNG.randi()
	#DoorNodesContainer.add_child(DoorNode)
