extends DimensionType

@onready var TerrainMesh = $TerrainMesh
@onready var objectSpawner = $ObjectSpawner
@onready var DoorNodesContainer = $DoorNodes

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

	var Objects = pick_random_objects(seed)
	
	for Count in range(1,RNG.randi_range(2,10)):
		objectSpawner.spawn_object(RNG,DoorObjectScene,generate_position())
	for ObjectScene in Objects:
		for Count in range(1,RNG.randi_range(2,10)):
			objectSpawner.spawn_object(RNG,ObjectScene[0],generate_position())

func generate_position():
	var Position = Vector3(RNG.randf_range(-124,124),0,RNG.randf_range(-124,124))
	Position.y = TerrainMesh.get_height_at(Vector2(Position.x,Position.z))
	return Position
