extends Node

@export var Song : AudioStream

func _ready() -> void:
	get_node("/root/SceneLoader").stop_music()
	get_node("/root/SceneLoader").play_music(Song)
