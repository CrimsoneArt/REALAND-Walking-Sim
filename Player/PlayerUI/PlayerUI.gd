extends Control

@onready var SeedLabel = $SeedLabel
@onready var CrossHair = $CrossHair
@onready var DialougeBox = $DialougeBox

var timer: Timer

func change_cross_hair(texture: Texture):
	CrossHair.texture = texture

func update_seed_label(seed):
	SeedLabel.text = "Seed : " + str(seed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ShowOrHideUI"):
		visible = not visible

func _process(delta: float) -> void:
	if DialougeBox.get_theme_stylebox("normal").texture == null:
		DialougeBox._on_change_texture_timer_timeout()

func show_dialouge(Text:String,Duration:float,FakeLand:=false):
	if DialougeBox is RandomizedButton:
		if timer:
			timer.queue_free()
		DialougeBox.text = Text
		DialougeBox.appear()
		timer = Timer.new()
		timer.wait_time = Duration
		timer.one_shot = true
		timer.autostart = true
		timer.timeout.connect(hide_dialouge)
		DialougeBox.FakeLand = FakeLand
		add_child(timer)

func hide_dialouge():
	DialougeBox.dissappear()
	timer.queue_free()
