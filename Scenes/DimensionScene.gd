extends Node3D

#this is the scene in which the dimension type is loaded

@export var DimensionTypes : Array[PackedScene]

@onready var World =  $WorldEnvironment
var seed: int

var RNG

func generate_dimension() -> Dictionary:
	RNG = RandomNumberGenerator.new()
	
	RNG.seed = seed
	
	var DimensionTypeScene = DimensionTypes[RNG.randi_range(0,DimensionTypes.size()-1)]
	
	var DimensionTypeNode = DimensionTypeScene.instantiate()
	
	add_child(DimensionTypeNode)
	
	DimensionTypeNode._generate_dimension(seed)
	
	var SkyBoxes: Array = []
	var Loader = FileLoader.new()
	SkyBoxes = Loader.get_file_paths_from_folder("res://Scenes/SkyBoxes/DimensionSkyboxes/",".png.import",".import")
	var SkyBox = SkyBoxes[RNG.randi()%SkyBoxes.size()]
	World.environment.sky.sky_material.set("shader_parameter/sky_texture",load(SkyBox))
	
	if RNG.randi_range(1,100) <= 55.67:
		World.environment.fog_enabled = true
		World.environment.fog_light_color = Color(RNG.randf_range(0.0,1.0),RNG.randf_range(0.0,1.0),RNG.randf_range(0.0,1.0))
		World.environment.fog_depth_curve = RNG.randf_range(0.0,19.0)
		World.environment.fog_depth_begin = RNG.randf_range(0.0,10.0)
		World.environment.fog_depth_end = RNG.randf_range(10.001,RNG.randf_range(10.011,75.0))
		World.environment.fog_sky_affect = RNG.randi_range(0,1)
		World.environment.fog_density = RNG.randf_range(0.0,1.0) 
		if DimensionTypeNode is CityDimensionType:
			World.environment.fog_density = RNG.randf_range(0.0,1.0) if RNG.randi()%2 == 1 else 1.0
	else:
		World.environment.fog_enabled = false
		
	var AssetsChosen = {
		"SkyBoxes":SkyBox,
		"Fog":{
			"Enabled":World.environment.fog_enabled,
			"SkyEffect":(true if World.environment.fog_sky_affect == 1.0 else false),
			"Density":World.environment.fog_density,
			"Begin":World.environment.fog_depth_begin,
		}
	}
	
	return AssetsChosen
