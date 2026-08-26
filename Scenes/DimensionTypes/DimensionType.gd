class_name DimensionType extends Node3D

var RNG = RandomNumberGenerator.new()
var DoorObjectScene = preload("res://Objects/Door/DoorObject.tscn")

func _generate_dimension(seed:int):
	assert(false, "_generate_dimension() must be overridden by the subclass.")

func spawn_objects(objectSpawner:ObjectSpawner,Objects:Array[PackedScene],generate_position:Callable,Materials:Array):
	for ObjectScene in Objects:
		var ObjectNode = ObjectScene.instantiate()
		if ObjectNode is GameObject:
			for Count in range(ObjectNode.amount_min,ObjectNode.amount_max):
				objectSpawner.spawn_object(RNG,ObjectScene,generate_position.call(),Materials)

func pick_random_materials(rng:RandomNumberGenerator):
	var Materials: Array[Material] = []
	var Dir = DirAccess.open("res://Materials/DimensionMaterials/")
	
	if Dir:
		Dir.list_dir_begin()
		var FileName = Dir.get_next()
		
		while FileName != "":
			if !Dir.current_is_dir() and FileName.ends_with(".tres"): #make sure the file is a material
				var FullPath = "res://Materials/DimensionMaterials/" + FileName
				var resource = load(FullPath)
				if resource:
					Materials.append(resource)
					
			FileName = Dir.get_next()
		Dir.list_dir_end()
	var MaterialNumber = rng.randi_range(1,6)
	for i in range(1,MaterialNumber):
		Materials.pop_at(rng.randi() % Materials.size())
	
	return Materials
	
func pick_random_objects(rng:RandomNumberGenerator) -> Array[PackedScene]:
	if rng.randf_range(0,100) <= 30:
		var Objects: Array[PackedScene] = []
		var Dir = DirAccess.open("res://Objects/ObjectsLibrary/")
		
		if Dir:
			Dir.list_dir_begin()
			var FileName = Dir.get_next()
			
			while FileName != "":
				if !Dir.current_is_dir() and FileName.ends_with(".tscn"):
					var FullPath = "res://Objects/ObjectsLibrary/" + FileName
					var ObjectScene = load(FullPath)
					var ObjectNode = ObjectScene.instantiate()
					if ObjectNode is GameObject:
						Objects.append(ObjectScene)
					
				FileName = Dir.get_next()
			Dir.list_dir_end()
		var ObjectsNumber : int
		if Objects.size() > 5:
			ObjectsNumber = Objects.size() - rng.randi_range(1,5)
		else:
			ObjectsNumber = rng.randi_range(1,3)
		for i in range(1,ObjectsNumber+1):
			Objects.pop_at(rng.randi() % Objects.size())
		return Objects
	else:
		return []

func pick_rare_objects(rng:RandomNumberGenerator):
	var Objects: Array[PackedScene] = []
	var Dir = DirAccess.open("res://Objects/ObjectsLibrary/RareObjectsLibrary/")
	
	if Dir:
		Dir.list_dir_begin()
		var FileName = Dir.get_next()
				
		while FileName != "":
			if !Dir.current_is_dir() and FileName.ends_with(".tscn"):
				var FullPath = "res://Objects/ObjectsLibrary/RareObjectsLibrary/" + FileName
				var ObjectScene = load(FullPath)
				var ObjectNode = ObjectScene.instantiate()
				if ObjectNode is GameObject:
					Objects.append(ObjectScene)
					
			FileName = Dir.get_next()
		Dir.list_dir_end()
	for i in range(0,Objects.size()-1):
		var ObjectNode = Objects[i].instantiate()
		if ObjectNode is GameObject:
			if ObjectNode.ChanceOfAppearing >= rng.randf_range(0,100):
				pass
			else:
				Objects.pop_at(i)
		else:
			Objects.pop_at(i)
	return Objects
