class_name DimensionType extends Node3D

var RNG = RandomNumberGenerator.new()
var DoorObjectScene = preload("res://Objects/Door/DoorObject.tscn")

func _generate_dimension(seed:int):
	assert(false, "_generate_dimension() must be overridden by the subclass.")

func spawn_objects(objectSpawner:ObjectSpawner,Objects:Array,generate_position:Callable,Materials:Array):
	for ObjectScene in Objects:
		var ObjectNode = ObjectScene.instantiate()
		if ObjectNode is GameObject:
			for Count in range(ObjectNode.amount_min*(2 if self is CityDimensionType else 1),ObjectNode.amount_max*(3 if self is CityDimensionType else 1)):
				objectSpawner.spawn_object(RNG,ObjectScene,generate_position.call(),Materials)

func pick_random_materials(rng:RandomNumberGenerator):
	var Materials: Array = []
	
	var Loader = FileLoader.new()
	
	Materials = Loader.get_file_paths_from_folder("res://Materials/DimensionMaterials/",".tres.remap",".remap")
	if Materials == []:
		Materials = Loader.get_file_paths_from_folder("res://Materials/DimensionMaterials/",".tres")
	
	var MaterialNumber = rng.randi_range(1,6)
	for i in range(1,Materials.size()-MaterialNumber):
		Materials.pop_at(rng.randi() % Materials.size())
		
	return Loader.load_files_in_array(Materials)
	
func pick_random_objects(rng:RandomNumberGenerator) -> Array[PackedScene]:
	if rng.randf_range(0,100) <= 30:
		var Objects: Array = []
		
		var Loader = FileLoader.new()
		Objects = Loader.get_file_paths_from_folder("res://Objects/ObjectsLibrary/",".tscn.remap",".remap")
		if Objects == []:
			Objects = Loader.get_file_paths_from_folder("res://Objects/ObjectsLibrary/",".tscn")
		
		var ObjectsNumber : int
		if Objects.size() > 4:
			ObjectsNumber = Objects.size() - rng.randi_range(1,4)
		else:
			ObjectsNumber = rng.randi_range(1,3)
		for i in range(1,ObjectsNumber+1):
			Objects.pop_at(rng.randi() % Objects.size())
			
		return Loader.load_files_in_array(Objects)
		
	else:
		return []

func pick_rare_objects(rng:RandomNumberGenerator):
	var Objects: Array = []
	
	var Loader = FileLoader.new()
	Objects = Loader.get_file_paths_from_folder("res://Objects/ObjectsLibrary/RareObjectsLibrary//",".tscn.remap",".remap")
	if Objects == []:
		Objects = Loader.get_file_paths_from_folder("res://Objects/ObjectsLibrary/RareObjectsLibrary/",".tscn")
	
	Objects = Loader.load_files_in_array(Objects)
	
	var OutPutObjects = []
	
	for i in range(0,Objects.size()):
		var ObjectNode = Objects[i].instantiate()
		if ObjectNode is GameObject:
			if ObjectNode.ChanceOfAppearing >= rng.randf_range(0.0,100.0):
				OutPutObjects.append(Objects[i])
	
	return OutPutObjects
