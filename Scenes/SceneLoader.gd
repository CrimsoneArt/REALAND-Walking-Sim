extends Node3D

const DimensionScene = preload("res://Scenes/DimensionScene.tscn")
var DimensionNode

@onready var MusicPlayer = $MusicPlayer

var Songs: Array = []

var Coins = 0

func readJSON(json_file_path:String):
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var finish = json.parse_string(content)
	return finish

func _ready() -> void:
	load_regular_scene("res://Scenes/Menus/AgreementMenu.tscn")
	
	var Loader = FileLoader.new()
	
	Songs = Loader.load_files_in_array(Loader.get_file_paths_from_folder("res://SFX/Music/MusicLibrary/",".wav"))

func load_regular_scene(ScenePath:String):
	kill_all_children()
	
	var Scene = load(ScenePath)
	add_child(Scene.instantiate())

func kill_all_children(): #mwuahahahha
	for child in get_children():
		if child != MusicPlayer:
			child.queue_free()

func load_dimension_scene(DimensionSeed:int):
	kill_all_children()
	
	var RNG = RandomNumberGenerator.new()
	RNG.seed = DimensionSeed
	
	DimensionNode = DimensionScene.instantiate()
	add_child(DimensionNode)
	DimensionNode.seed = DimensionSeed
	
	#Picking a song with a fitting mood :
	
	var AssetsChosen = DimensionNode.generate_dimension()
	
	stop_music()
	
	var MoodData = readJSON("res://MoodData.json")
	
	var SkyMood : Array[float]
	for i in range(0,5):
		SkyMood.append(MoodData["SkyBoxes"][AssetsChosen["SkyBoxes"]][i])
	
	
	
	var Mood : Array[float] = SkyMood
	if AssetsChosen["Fog"]["SkyEffect"]:
		Mood = [0.0,1.0,1.0,0.5,1.0]
	Mood[0] = lerp(Mood[0],0.0,AssetsChosen["Fog"]["Density"]/3.0)
	Mood[1] = lerp(Mood[1],1.0,AssetsChosen["Fog"]["Density"]/3.0)
	Mood[2] = lerp(Mood[2],1.0,AssetsChosen["Fog"]["Density"]/3.0)
	Mood[3] = lerp(Mood[3],0.5,AssetsChosen["Fog"]["Density"]/3.0)
	Mood[4] = lerp(Mood[4],1.0,AssetsChosen["Fog"]["Density"]/3.0)
	
	print(Mood)
	
	for material in AssetsChosen["Materials"]:
		for i in range(0,5):
			Mood[i] = lerp(Mood[i],MoodData["Materials"][material][i],0.2)
	
	Mood[0] *= 1.15
	Mood[1] *= 1.12
	Mood[2] *= 0.98
	Mood[3] *= 1.11
	Mood[4] *= 0.99
	
	var Song = find_most_similar(MoodData["Music"],Mood)
	
	print(Mood)
	print(MoodData["Music"][Song])
	print("-----")
	play_music(load(Song))

func find_most_similar(dict: Dictionary, target: Array[float]) -> String:
	var best_key: String = ""
	var lowest_distance: float = INF
	
	for key in dict:
		var current_array: Array = dict[key]
		var distance: float = 0.0
		
		for i in range(target.size()):
			var diff: float = target[i] - current_array[i]
			distance += diff * diff # Squared distance
			
		if distance < lowest_distance:
			lowest_distance = distance
			best_key = str(key)
	
	return best_key

func get_dimension_seed():
	return DimensionNode.seed if DimensionNode != null else null

func play_music(stream:AudioStream,volume_db:=-10):
	MusicPlayer.stream = stream
	MusicPlayer.volume_db = volume_db
	MusicPlayer.play()

func stop_music():
	MusicPlayer.stop()
