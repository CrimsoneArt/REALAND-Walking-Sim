extends Control

@onready var SeedLabel = $SeedLabel
@onready var CrossHair = $CrossHair
@onready var DialougeBox = $DialougeBox

var timer: Timer

func _ready() -> void:
	update_coin_counter()

func change_cross_hair(texture: Texture):
	CrossHair.texture = texture

func update_seed_label(seed):
	SeedLabel.text = "Seed : " + str(seed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ShowOrHideUI"):
		visible = not visible

func _process(delta: float) -> void:
	if DialougeBox.get_theme_stylebox("normal") is StyleBoxTexture:
		if DialougeBox.get_theme_stylebox("normal").texture == null:
			DialougeBox._on_change_texture_timer_timeout()

func show_dialouge(Dialouge:DialougeText):
	if DialougeBox is RandomizedButton:
		if timer:
			timer.queue_free()
		DialougeBox.text = Dialouge.Dialouge
		DialougeBox.appear()
		timer = Timer.new()
		timer.wait_time = Dialouge.Duration
		timer.one_shot = true
		timer.autostart = true
		timer.timeout.connect(hide_dialouge)
		DialougeBox.FakeLand = Dialouge.FakeLand
		add_child(timer)

func hide_dialouge():
	DialougeBox.dissappear()
	timer.queue_free()

func play_coin_animation():
	$AnimationPlayer.play("GainCoin")

func gain_coin():
	get_node("/root/SceneLoader").Coins += 1
	update_coin_counter()

func update_coin_counter():
	if get_node("/root/SceneLoader") != null:
		if get_node("/root/SceneLoader").Coins > 0:
			$CoinLabel.text = "  x " + str(get_node("/root/SceneLoader").Coins)
			$Coin.visible = true
		else:
			$CoinLabel.text = ""
			$Coin.visible = false
