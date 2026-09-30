class_name RandomizedButton extends Button

@export var ForceQuit := false
@export var EnterTargetScene := false
@export var TargetScenePath : String
@export var StartingTargetScale := Vector2(1.0,1.0)
@export var FakeLand := false:
	set(value):
		FakeLand = value
		if value:
			set_to_fakeland()
		else:
			unset_to_fakeland()
@export var CustomThemeOverride := false:
	set(value):
		CustomThemeOverride = value
		if value:
			_remove_theme_override()
		else:
			add_theme_stylebox_override("normal", stylebox_normal.duplicate())
			add_theme_stylebox_override("hover", stylebox_hover.duplicate())
			_on_change_texture_timer_timeout()
@export var MaxHoverSize := Vector2(2.0,2.0)
@export var EnterURL := false
@export var URL := ""

func _remove_theme_override():
	remove_theme_stylebox_override("normal")
	remove_theme_stylebox_override("hover")
	remove_theme_color_override("font_color")
	remove_theme_color_override("font_outline_color")
	remove_theme_constant_override("outline_size")
	remove_theme_font_override("font")

var target_scale : Vector2
var stylebox_normal
var stylebox_hover

func _ready() -> void:
	stylebox_normal = get_theme_stylebox("normal")
	stylebox_hover = get_theme_stylebox("hover")
	target_scale = StartingTargetScale
	if not CustomThemeOverride:
		add_theme_stylebox_override("normal", stylebox_normal.duplicate())
	pivot_offset = size/2.0
	$ChangeTextureTimer.start()

func _on_pressed() -> void:
	if ForceQuit:
		get_tree().quit()
	else:
		if EnterTargetScene:
			get_node("/root/SceneLoader").load_regular_scene(TargetScenePath)
		if EnterURL:
			OS.shell_open(URL)

func _on_change_texture_timer_timeout() -> void:
	if not CustomThemeOverride:
		if not FakeLand:
			get_theme_stylebox("normal").texture = load("res://Scenes/Menus/RandomizedButtonSprites/RandomizedButtonSprite"+str(randi_range(1,5))+".png")
			set("theme_override_colors/font_color", Color(randf(), randf(), randf(), 1.0))
			set("theme_override_colors/font_outline_color", Color(randf(), randf(), randf(), 1.0))
			set("theme_override_constants/outline_size", randi_range(0,12))
			var font_number = randi_range(1,7)
			var font = load("res://Scenes/Menus/Fonts/"+str(font_number)+".otf")
			if font == null:
				font = load("res://Scenes/Menus/Fonts/"+str(font_number)+".ttf")
			set("theme_override_fonts/font", font)
			

func _process(delta: float) -> void:
	scale = lerp(scale,target_scale,delta*4.0)

func _on_mouse_entered() -> void:
	pivot_offset = size/2.0
	get_parent().move_child(self, -1) 
	target_scale = MaxHoverSize

func _on_mouse_exited() -> void:
	pivot_offset = size/2.0
	target_scale = Vector2(1.0,1.0)

func appear():
	pivot_offset = size/2.0
	scale = Vector2(0.0,0.0)
	target_scale = Vector2(1.0,1.0)
	_on_change_texture_timer_timeout()
	$ChangeTextureTimer.start()

func dissappear():
	pivot_offset = size/2.0
	scale = Vector2(1.0,1.0)
	target_scale = Vector2(0.0,0.0)

func set_to_fakeland():
	set("theme_override_styles/normal",load("res://Scenes/Menus/FakeLandButton.tres"))
	set("theme_override_colors/font_color", Color(1.0, 1.0, 1.0, 1.0))
	set("theme_override_constants/outline_size", 0.0)
	var font = load("res://Scenes/Menus/Fonts/6.ttf")
	set("theme_override_fonts/font", font)
	
func unset_to_fakeland():
	set("theme_override_styles/normal",StyleBoxTexture.new())
	_on_change_texture_timer_timeout()
