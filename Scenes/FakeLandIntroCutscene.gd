extends Control

func _ready() -> void:
	$AnimationPlayer.play("FakeLandIntroCutscene")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_node("/root/SceneLoader").load_regular_scene("res://Scenes/FakeLandScene.tscn","Instant")
