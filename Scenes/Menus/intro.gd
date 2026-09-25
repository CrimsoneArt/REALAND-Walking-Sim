extends Control

var s = 0
var opacity = 0

func _ready():
	$TextureRect.visible = false

func _process(delta):
	s += 0.25 * delta
	opacity += 0.25 * delta
	$Title.scale.x = s
	$Title.scale.y = s
	var o = (((opacity*2)-1)*((opacity*2)-1))
	$Title.material.set("shader_parameter/intensity",o)
	if s >= 1.25 and opacity >= 1.5 and $Timer.is_stopped(): 
		get_node("/root/SceneLoader").play_music(load("res://SFX/Music/MainMenuOST.wav"),-3.0)
		$Timer.start()
		$TextureRect.visible = true

#get_node("/root/SceneLoader").load_regular_scene("res://Scenes/Menus/MainMenu.tscn")

func _on_timer_timeout() -> void:
	if $TextureRect.visible == false:
		get_node("/root/SceneLoader").load_regular_scene("res://Scenes/Menus/MainMenu.tscn","Instant")
	else:
		$TextureRect.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("SkipCutscene"):
		get_node("/root/SceneLoader").load_regular_scene("res://Scenes/Menus/MainMenu.tscn","Instant")
