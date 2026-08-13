class_name Dimension extends Node3D

var seed : int

@export var DimensionTypes : Array[PackedScene]

@onready var DoorNodesContainer = $DoorNodes
@onready var World =  $WorldEnvironment

var RNG

func _ready() -> void:
	RNG = RandomNumberGenerator.new()
	
	RNG.seed = seed
	
	var DimensionTypeScene = DimensionTypes[RNG.randi_range(0,DimensionTypes.size()-1)]
	
	var DimensionTypeNode = DimensionTypeScene.instantiate()
	
	add_child(DimensionTypeNode)
	
	DimensionTypeNode._generate_dimension(seed)
	
	World.environment.sky.sky_material.set("shader_parameter/sky_texture", load("res://Scenes/SkyBoxes/SkyBox"+str(RNG.randi_range(1,7))+".png"))
	
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
