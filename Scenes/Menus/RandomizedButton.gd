extends Button

@export var ForceQuit := false
@export var EnterTargetScene := false
@export var TargetScenePath : String

var target_scale = Vector2(1.0,1.0)

func _ready() -> void:
	add_theme_stylebox_override("normal", get_theme_stylebox("normal").duplicate())
	pivot_offset = size/2.0

func _on_pressed() -> void:
	if ForceQuit:
		get_tree().quit()
	elif EnterTargetScene:
		get_node("/root/SceneLoader").load_regular_scene(TargetScenePath)

func _on_change_texture_timer_timeout() -> void:
	get_theme_stylebox("normal").texture = load("res://Scenes/Menus/RandomizedButtonSprites/RandomizedButtonSprite"+str(randi_range(1,5))+".png")
	set("theme_override_colors/font_color", Color(randf(), randf(), randf(), 1.0))
	set("theme_override_colors/font_outline_color", Color(randf(), randf(), randf(), 1.0))
	set("theme_override_constants/outline_size", randi_range(0,12))
	var font_number = randi_range(1,8)
	var font = load("res://Scenes/Menus/Fonts/"+str(font_number)+".otf")
	if font == null:
		font = load("res://Scenes/Menus/Fonts/"+str(font_number)+".ttf")
	set("theme_override_fonts/font", font)

func _process(delta: float) -> void:
	scale = lerp(scale,target_scale,delta*4.0)

func _on_mouse_entered() -> void:
	target_scale = Vector2(2.0,2.0)

func _on_mouse_exited() -> void:
	target_scale = Vector2(1.0,1.0)
