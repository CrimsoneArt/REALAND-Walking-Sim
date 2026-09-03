extends DimensionType

@onready var objectSpawner = $ObjectSpawner
@onready var Floor = $CSGCombiner3D/Floor
var CityDimensionBuilding = preload("res://Scenes/DimensionTypes/CityDimensionBuilding.tscn")

func _generate_dimension(seed:int):
	
	var Objects = pick_random_objects(RNG)
	
	var Materials = pick_random_materials(RNG)
	
	Floor.material = Materials[RNG.randi()%Materials.size()]
	
	for i in range(0,randi_range(40,120)):
		var CityDimensionBuildingNode = CityDimensionBuilding.instantiate()
		CityDimensionBuildingNode.position = generate_position()
		CityDimensionBuildingNode.material = Materials[RNG.randi()%Materials.size()]
		CityDimensionBuildingNode.size.y = randi_range(5,25)
		CityDimensionBuildingNode.size.x = randi_range(5,25)
		CityDimensionBuildingNode.size.z = randi_range(5,25)
		$CSGCombiner3D.add_child(CityDimensionBuildingNode)
	
	spawn_objects(objectSpawner,[DoorObjectScene],generate_position,[])
	
	var RareObjects = pick_rare_objects(RNG)
	
	spawn_objects(objectSpawner,RareObjects,generate_position,Materials)
	spawn_objects(objectSpawner,Objects,generate_position,Materials)

func generate_position():
	return Vector3(RNG.randi_range(-100,100),0,RNG.randi_range(-100,100))
