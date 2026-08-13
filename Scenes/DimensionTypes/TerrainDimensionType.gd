extends DimensionType

@onready var TerrainMesh = $TerrainMesh

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
	
	for i in range(1,RNG.randi_range(2,10)):
		generate_door()
	
	var Materials = pick_random_materials(seed)
	TerrainMesh.material_override = Materials[RNG.randi() % Materials.size()]

func generate_door():
	var DoorNode = DoorScene.instantiate()
	var DoorPosition = Vector3(RNG.randf_range(-124,124),RNG.randf_range(-124,124),0)
	DoorPosition.y = TerrainMesh.noise.get_noise_2d(DoorPosition.x, DoorPosition.z) * TerrainMesh.height
	DoorNode.position = DoorPosition
	DoorNode.seed = RNG.randi()
	DoorNode.rotation.y = RNG.randf_range(-360,360)
	DoorNodesContainer.add_child(DoorNode)
