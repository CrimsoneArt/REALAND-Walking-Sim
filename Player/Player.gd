class_name Player extends CharacterBody3D

const CrossHair1 = preload("res://Player/PlayerUI/CrossHair1.png")
const CrossHair2 = preload("res://Player/PlayerUI/CrossHair2.png")

const Speed = 4.0
const JumpVelocity = 4.5

const Gravity = 9.8

const Sensitivity = 0.03

@onready var Head = $Head
@onready var Camera = $Head/Camera3D
@onready var InteractableChecker = $Head/RayCast3D
@onready var PlayerUi = $PlayerUI

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if get_node("/root/SceneLoader"):
		PlayerUi.update_seed_label(get_node("/root/SceneLoader").get_dimension_seed())

func _process(delta: float) -> void:
	if Input.is_action_pressed("Left"):
		Head.rotate_y(1.0 * Sensitivity)
	elif Input.is_action_pressed("Right"):
		Head.rotate_y(-1.0 * Sensitivity)
	
	if InteractableChecker.is_colliding():
		var Collider = InteractableChecker.get_collider()
		PlayerUi.change_cross_hair(CrossHair2)
		if Input.is_action_just_pressed("Enter"):
			if Collider is InteractabilityComponent:
				Collider.interact(self)
	else:
		PlayerUi.change_cross_hair(CrossHair1)

	if Input.is_action_just_pressed("PinchCheek"):
		get_node("/root/SceneLoader").load_regular_scene("res://Scenes/HubWorld.tscn")
	
	if global_position.y <= -47.5:
		get_node("/root/SceneLoader").load_regular_scene("res://Scenes/BackRoomsScene.tscn")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= Gravity * delta

	var moving_forward_or_backward = (1.0 if Input.is_action_pressed("Up") else (-1.0 if Input.is_action_pressed("Down") else 0.0))

	position += Speed * delta * -Head.global_transform.basis.z.normalized() * moving_forward_or_backward

	move_and_slide()

func show_dialouge(Dialouge:DialougeText):
	PlayerUi.show_dialouge(Dialouge)

func gain_coin():
	$PlayerUI.gain_coin()
	get_tree().paused = true
	ColorBander.get_node("Control/AnimationPlayer").play("GainCoin")
	await ColorBander.get_node("Control/AnimationPlayer").animation_finished
	get_tree().paused = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ReturnToMainMenu"):
		get_node("/root/SceneLoader").load_regular_scene("res://Scenes/Menus/MainMenu.tscn")
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
