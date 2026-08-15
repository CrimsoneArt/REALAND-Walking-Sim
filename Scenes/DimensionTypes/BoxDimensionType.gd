extends DimensionType

@onready var Floor = $CSGCombiner3D/Floor
@onready var CeilingRemover = $CSGCombiner3D/Floor/CeilingRemover
@onready var Player = $Player
@onready var ObjectSpawner = $ObjectSpawner

func _generate_dimension(Seed:int):
	RNG.seed = Seed
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
	
	var Objects = pick_random_objects(Seed)
	
	
	for Count in range(1,RNG.randi_range(2,10)):
		ObjectSpawner.spawn_object(Seed,DoorObjectScene,generate_position(FloorSizeX,FloorSizeZ),{"Seed":RNG.randi()})
	for ObjectScene in Objects:
		for Count in range(1,RNG.randi_range(2,10)):
			ObjectSpawner.spawn_object(Seed,ObjectScene,generate_position(FloorSizeX,FloorSizeZ))

	var Materials = pick_random_materials(Seed)
	Floor.material = Materials[RNG.randi() % Materials.size()]
	CeilingRemover.material = Materials[RNG.randi() % Materials.size()]

func generate_position(FloorSizeX:float,FloorSizeZ:float) -> Vector3:
	return Vector3(RNG.randi_range((-FloorSizeX/2.0)+2.5,(FloorSizeX/2.0)-2.5),0,RNG.randi_range((-FloorSizeZ/2.0)+2.5,(FloorSizeZ/2.0)-2.5))
