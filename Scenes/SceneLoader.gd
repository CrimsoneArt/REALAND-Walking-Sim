extends Node3D

const DimensionScene = preload("res://Scenes/DimensionScene.tscn")
var DimensionNode

func _ready() -> void:
	load_regular_scene("res://Scenes/Menus/MainMenu.tscn")

func load_regular_scene(ScenePath:String):
	kill_all_children()
	
	var Scene = load(ScenePath)
	add_child(Scene.instantiate())

func kill_all_children(): #mwuahahahha
	for child in get_children():
		child.queue_free()

func load_dimension_scene(DimensionSeed:int):
	kill_all_children()
		
	DimensionNode = DimensionScene.instantiate()
	DimensionNode.seed = DimensionSeed
	add_child(DimensionNode)

func get_dimension_seed():
	return DimensionNode.seed if DimensionNode != null else null
