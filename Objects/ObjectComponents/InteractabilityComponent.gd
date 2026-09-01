class_name InteractabilityComponent extends Area3D

signal Interacted(PlayerNode:Player)

@export_category("Sound Effect")
@export var SoundEffect : AudioStream
@export var Pitch_Min := 0.8
@export var Pitch_Max := 1.4

@export_category("Target Scene")
@export var TargetScene : PackedScene

func interact(PlayerNode:Player):
	$AudioStreamPlayer3D.stream = SoundEffect
	$AudioStreamPlayer3D.pitch_scale = randf_range(Pitch_Min,Pitch_Max)
	$AudioStreamPlayer3D.play()
	if TargetScene:
		get_node("/root/SceneLoader").load_regular_scene(TargetScene.resource_path)
	Interacted.emit(PlayerNode)
