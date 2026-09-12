extends Control

var s = 0
var opacity = 0

func _process(delta):
	s += 0.25 * delta
	opacity += 0.25 * delta
	$Title.scale.x = s
	$Title.scale.y = s
	var o = (((opacity*2)-1)*((opacity*2)-1))
	$Title.material.set("shader_parameter/intensity",o)
	if s >= 1.25 and opacity >= 1:
		get_node("/root/SceneLoader").load_regular_scene("res://Scenes/Menus/MainMenu.tscn")
