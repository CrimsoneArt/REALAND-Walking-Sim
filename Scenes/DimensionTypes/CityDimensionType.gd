class_name CityDimensionType extends DimensionType

@onready var objectSpawner = $ObjectSpawner
@onready var Floor = $CSGCombiner3D/Floor
var CityDimensionBuilding = preload("res://Scenes/DimensionTypes/CityDimensionBuilding.tscn")

func _generate_dimension(seed:int):
	
	var Objects = pick_random_objects(RNG)
	
	var Materials = pick_random_materials(RNG)
	
	Floor.material = Materials[RNG.randi()%Materials.size()]
	
	var size_y_min = RNG.randf_range(1,20)
	var size_y_max = RNG.randf_range(20.2,60.0)
	
	for i in range(0,RNG.randi_range(40,120)):
		var CityDimensionBuildingNode = CityDimensionBuilding.instantiate()
		CityDimensionBuildingNode.position = generate_position()
		CityDimensionBuildingNode.material = Materials[RNG.randi()%Materials.size()]
		CityDimensionBuildingNode.size.y = RNG.randf_range(size_y_min,size_y_max)
		CityDimensionBuildingNode.size.x = RNG.randf_range(5,28)
		CityDimensionBuildingNode.size.z = RNG.randf_range(5,28)
		$CSGCombiner3D.add_child(CityDimensionBuildingNode)
	
	spawn_objects(objectSpawner,[DoorObjectScene],generate_position,[])
	
	var RareObjects = pick_rare_objects(RNG)
	
	spawn_objects(objectSpawner,RareObjects,generate_position,Materials)
	spawn_objects(objectSpawner,Objects,generate_position,Materials)

func generate_position():
	return Vector3(RNG.randi_range(-100,100),0,RNG.randi_range(-100,100))
