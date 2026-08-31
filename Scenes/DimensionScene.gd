extends Node3D

#this is the scene in which the dimension type is loaded

var seed : int

@export var DimensionTypes : Array[PackedScene]

@onready var World =  $WorldEnvironment

var RNG

func _ready() -> void:
	RNG = RandomNumberGenerator.new()
	
	RNG.seed = seed
	
	var DimensionTypeScene = DimensionTypes[RNG.randi_range(0,DimensionTypes.size()-1)]
	
	var DimensionTypeNode = DimensionTypeScene.instantiate()
	
	add_child(DimensionTypeNode)
	
	DimensionTypeNode._generate_dimension(seed)
	
	var SkyBoxes: Array = []
	var Loader = FileLoader.new()
	SkyBoxes = Loader.get_file_paths_from_folder("res://Scenes/SkyBoxes/DimensionSkyboxes/",".png")
	SkyBoxes = Loader.load_files_in_array(SkyBoxes)
	
	World.environment.sky.sky_material.set("shader_parameter/sky_texture", SkyBoxes[RNG.randi()%SkyBoxes.size()])
	
	if RNG.randi_range(1,100) <= 55.67:
		World.environment.fog_enabled = true
		World.environment.fog_light_color = Color(RNG.randf_range(0.0,1.0),RNG.randf_range(0.0,1.0),RNG.randf_range(0.0,1.0))
		World.environment.fog_depth_curve = RNG.randf_range(0.0,19.0)
		World.environment.fog_depth_begin = RNG.randf_range(0.0,10.0)
		World.environment.fog_depth_end = RNG.randf_range(10.001,RNG.randf_range(10.011,75.0))
		World.environment.fog_sky_affect = RNG.randi_range(0,1)
		World.environment.fog_density = RNG.randf_range(0.1,1.0)
	else:
		World.environment.fog_enabled = false
