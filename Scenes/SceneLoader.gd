extends Node3D

const DimensionScene = preload("res://Scenes/DimensionScene.tscn")
var DimensionNode

@onready var MusicPlayer = $MusicPlayer

var Songs: Array = []

func _ready() -> void:
	load_regular_scene("res://Scenes/Menus/Intro.tscn")
	
	var Loader = FileLoader.new()
	
	Songs = Loader.load_files_in_array(Loader.get_file_paths_from_folder("res://SFX/Music/MusicLibrary/",".wav"))

func load_regular_scene(ScenePath:String):
	kill_all_children()
	
	var Scene = load(ScenePath)
	add_child(Scene.instantiate())
	
	MusicPlayer.stop()

func kill_all_children(): #mwuahahahha
	for child in get_children():
		if child != MusicPlayer:
			child.queue_free()

func load_dimension_scene(DimensionSeed:int):
	kill_all_children()
	
	var RNG = RandomNumberGenerator.new()
	RNG.seed = DimensionSeed
	
	DimensionNode = DimensionScene.instantiate()
	DimensionNode.seed = DimensionSeed
	add_child(DimensionNode)
	
	MusicPlayer.stream = Songs[RNG.randi()%Songs.size()]
	MusicPlayer.stop()
	MusicPlayer.play()

func get_dimension_seed():
	return DimensionNode.seed if DimensionNode != null else null
