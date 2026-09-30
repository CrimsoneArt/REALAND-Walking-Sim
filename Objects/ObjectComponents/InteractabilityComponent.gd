class_name InteractabilityComponent extends Area3D

signal Interacted(PlayerNode:Player)

@export_category("Sound Effect")
@export var SoundEffect : AudioStream
@export var Pitch_Min := 0.8
@export var Pitch_Max := 1.4

@export_category("Target Scene")
@export var TargetScene : PackedScene

@export_category("Dialouge")
@export var Dialouge : Array[DialougeText]
@export_enum("Random","Linear (Stop)", "Linear (Loop)") var DialougeType := 0

var DialougeIndex = 0

func interact(PlayerNode:Player):
	$AudioStreamPlayer3D.stream = SoundEffect
	$AudioStreamPlayer3D.pitch_scale = randf_range(Pitch_Min,Pitch_Max)
	$AudioStreamPlayer3D.play()
	if TargetScene:
		get_node("/root/SceneLoader").load_regular_scene(TargetScene.resource_path)
	if Dialouge.size() > 0:
		if DialougeType == 0:
			PlayerNode.show_dialouge(Dialouge.pick_random())
		elif DialougeType == 1:
			PlayerNode.show_dialouge(Dialouge[DialougeIndex])
			if not DialougeIndex >= Dialouge.size() - 1:
				DialougeIndex += 1
		elif DialougeType == 2:
			PlayerNode.show_dialouge(Dialouge[DialougeIndex])
			DialougeIndex += 1
			DialougeIndex = DialougeIndex % Dialouge.size()
	Interacted.emit(PlayerNode)
