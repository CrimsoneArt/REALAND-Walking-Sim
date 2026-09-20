extends Node3D

func _ready() -> void:
	get_node("/root/SceneLoader").stop_music()

func door_opened():
	var x = randi_range(1,50)
	if x == 1:
		get_node("/root/SceneLoader").load_regular_scene("res://Scenes/ForgottenScene.tscn")
