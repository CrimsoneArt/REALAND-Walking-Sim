extends DimensionType

@onready var TerrainMesh = $TerrainMesh
@onready var objectSpawner = $ObjectSpawner
@onready var DoorNodesContainer = $DoorNodes
@onready var Player = $Player

func _generate_dimension(seed:int):
	RNG.seed = seed
	TerrainMesh.set_seed(seed)
	TerrainMesh.noise.frequency = RNG.randf_range(0.005,0.0225)
	TerrainMesh.height = RNG.randi_range(10,40)
	TerrainMesh.noise.noise_type = RNG.randi_range(0,5)
	TerrainMesh.noise.fractal_weighted_strength = RNG.randf_range(RNG.randf_range(0.0,0.5),1.0)
	TerrainMesh.noise.fractal_gain = RNG.randf_range(0.0,1.0)
	TerrainMesh.update_mesh()
	
	
	var Materials = pick_random_materials(seed)
	TerrainMesh.material_override = Materials[RNG.randi() % Materials.size()]
	var Objects = pick_random_objects(RNG.seed)
	spawn_objects(objectSpawner,Objects,generate_position,Materials)
	spawn_objects(objectSpawner,[DoorObjectScene],generate_position,Materials)

	Player.position = Vector3(0,TerrainMesh.get_height_at(Vector2(0,0))+2.0,0)

func generate_position():
	var Position = Vector3(RNG.randf_range(-124,124),0,RNG.randf_range(-124,124))
	Position.y = TerrainMesh.get_height_at(Vector2(Position.x,Position.z))
	return Position
