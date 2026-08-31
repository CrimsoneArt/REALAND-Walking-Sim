extends DimensionType

@onready var Floor = $CSGCombiner3D/Floor
@onready var CeilingRemover = $CSGCombiner3D/Floor/CeilingRemover
@onready var Player = $Player
@onready var objectSpawner = $ObjectSpawner

var FloorSizeX
var FloorSizeZ
var FloorSizeY

func _generate_dimension(Seed:int):
	RNG.seed = Seed
	FloorSizeX = RNG.randi_range(20,250)
	FloorSizeZ = RNG.randi_range(20,250)
	FloorSizeY = RNG.randi_range(5.0,15.0)
	
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
	
	spawn_objects(objectSpawner,[DoorObjectScene],generate_position,[])
	var Materials = pick_random_materials(RNG)
	Floor.material = Materials[RNG.randi() % Materials.size()]
	CeilingRemover.material = Materials[RNG.randi() % Materials.size()]
	var Objects = pick_random_objects(RNG)
	
	var RareObjects = pick_rare_objects(RNG)
	
	spawn_objects(objectSpawner,RareObjects,generate_position,Materials)
	spawn_objects(objectSpawner,Objects,generate_position,Materials)

func generate_position() -> Vector3:
	return Vector3(RNG.randi_range((-FloorSizeX/2.0)+2.5,(FloorSizeX/2.0)-2.5),0,RNG.randi_range((-FloorSizeZ/2.0)+2.5,(FloorSizeZ/2.0)-2.5))
