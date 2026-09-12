extends Node3D

func _ready() -> void:
	get_node("/root/SceneLoader").stop_music()
