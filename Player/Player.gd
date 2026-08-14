extends CharacterBody3D

const CrossHair1 = preload("res://Player/PlayerUI/CrossHair1.png")
const CrossHair2 = preload("res://Player/PlayerUI/CrossHair2.png")

const Speed = 5.0
const JumpVelocity = 4.5

const Gravity = 9.8

const Sensitivity = 0.03

@onready var Head = $Head
@onready var Camera = $Head/Camera3D
@onready var InteractableChecker = $Head/RayCast3D
@onready var PlayerUI = $PlayerUI

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	PlayerUI.update_seed_label(get_node("/root/SceneLoader").get_dimension_seed())

func _process(delta: float) -> void:
	if Input.is_action_pressed("Left"):
		Head.rotate_y(1.0 * Sensitivity)
	elif Input.is_action_pressed("Right"):
		Head.rotate_y(-1.0 * Sensitivity)
	
	if InteractableChecker.is_colliding():
		var Collider = InteractableChecker.get_collider()
		PlayerUI.change_cross_hair(CrossHair2)
		if Input.is_action_just_pressed("Enter"):
			if Collider is InteractabilityComponent:
				Collider.interact()
	else:
		PlayerUI.change_cross_hair(CrossHair1)

	if Input.is_action_just_pressed("PinchCheek"):
		get_node("/root/SceneLoader").load_regular_scene("res://Scenes/HubWorld.tscn")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= Gravity * delta

	var moving_forward_or_backward = (1.0 if Input.is_action_pressed("Up") else (-1.0 if Input.is_action_pressed("Down") else 0.0))

	position += Speed * delta * -Head.global_transform.basis.z.normalized() * moving_forward_or_backward

	move_and_slide()
