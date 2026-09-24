@tool
class_name RegularButton extends Button

@export var ForceQuit := false
@export var EnterTargetScene := false
@export var TargetScenePath : String
@export var StartingTargetScale := Vector2(1.0,1.0)

var target_scale : Vector2
var stylebox_normal
var stylebox_hover

func _ready() -> void:
	target_scale = StartingTargetScale

func _on_pressed() -> void:
	if ForceQuit:
		get_tree().quit()
	elif EnterTargetScene:
		get_node("/root/SceneLoader").load_regular_scene(TargetScenePath)

func _process(delta: float) -> void:
	scale = lerp(scale,target_scale,delta*4.0)

func _on_mouse_entered() -> void:
	pivot_offset = size/2.0
	get_parent().move_child(self, -1) 
	target_scale = Vector2(2.0,2.0)

func _on_mouse_exited() -> void:
	pivot_offset = size/2.0
	target_scale = Vector2(1.0,1.0)

func appear():
	pivot_offset = size/2.0
	scale = Vector2(0.0,0.0)
	target_scale = Vector2(1.0,1.0)

func dissappear():
	pivot_offset = size/2.0
	scale = Vector2(1.0,1.0)
	target_scale = Vector2(0.0,0.0)
