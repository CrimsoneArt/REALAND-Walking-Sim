class_name FileLoader extends Node

func get_file_paths_from_folder(Directory:String,Suffix:String,SuffixTrim:="") -> Array[String]:
	var Files: Array[String] = []
	var Dir = DirAccess.open(Directory)
	
	if Dir:
		Dir.list_dir_begin()
		var FileName = Dir.get_next()
		while FileName != "":
			if !Dir.current_is_dir() and FileName.ends_with(Suffix):
				var FullPath = Directory + FileName.trim_suffix(SuffixTrim)
				Files.append(FullPath)
					
			FileName = Dir.get_next()
		Dir.list_dir_end()
	
	return Files

func load_files_in_array(InputArray) -> Array:
	var OutPutArray := []
	for Path in InputArray:
		OutPutArray.append(load(Path))
	return OutPutArray
