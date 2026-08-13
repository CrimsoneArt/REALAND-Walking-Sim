class_name DimensionType extends Node3D

var RNG = RandomNumberGenerator.new()

func _generate_dimension(seed:int):
	assert(false, "_generate_dimension() must be overridden by the subclass.")

func pick_random_materials(seed:int):
	var Materials: Array = []
	var Dir = DirAccess.open("res://Materials/")
	
	if Dir:
		Dir.list_dir_begin()
		var FileName = Dir.get_next()
		
		while FileName != "":
			if !Dir.current_is_dir() and FileName.ends_with(".tres"): #make sure the file is a material
				var FullPath = "res://Materials/" + FileName
				var resource = load(FullPath)
				if resource:
					Materials.append(resource)
					
			FileName = Dir.get_next()
		Dir.list_dir_end()
	RNG.seed = seed
	var MaterialNumber = RNG.randi_range(1,Materials.size()-1)
	for i in range(1,MaterialNumber):
		Materials.pop_at(RNG.randi() % Materials.size())
	return Materials
	
