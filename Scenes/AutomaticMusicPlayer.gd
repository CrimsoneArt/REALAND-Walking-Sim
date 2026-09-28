extends Node

@export var Song : AudioStream
@export var VolumeDB : float

func _ready() -> void:
	if get_node("/root/SceneLoader") != null:
		get_node("/root/SceneLoader").stop_music()
		get_node("/root/SceneLoader").play_music(Song,VolumeDB)

# One singular bug.
