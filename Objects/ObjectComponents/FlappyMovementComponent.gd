class_name FlappyMovementComponent extends WanderComponent

@export var min_height := 3.0
@export var max_height := 7.0
@export var min_jump_strength := 5.0
@export var max_jump_strengh := 15.0
@export var min_jump_wait_time := 0.1
@export var max_jump_wait_time := 1.5
@export var JumpSfx : AudioStream
@export var JumpSfxPitchMin := 0.8
@export var JumpSfxPitchMax := 1.4
@export var AudioPlayer : AudioStreamPlayer3D

var flapping_timer := Timer.new()

func _ready() -> void:
	add_child(flapping_timer)
	flapping_timer.timeout.connect(flap)
	flap()

func flap() -> void:
	if AudioPlayer != null:
		AudioPlayer.stream = JumpSfx
		AudioPlayer.pitch_scale = randf_range(JumpSfxPitchMin,JumpSfxPitchMax)
		AudioPlayer.play()
	
	var current_y: float = MovementNode.global_position.y
	var height_factor: float = clampf((current_y - min_height) / (max_height - min_height), 0.0, 1.0)
	flapping_timer.wait_time = lerp(min_jump_wait_time, max_jump_wait_time, height_factor)
	flapping_timer.start()
	
	var target_strength: float = lerp(max_jump_strengh, min_jump_strength, height_factor)
	MovementNode.velocity.y = target_strength * randf_range(0.8, 1.2)
	State = States[2]

func _update_movement(delta: float) -> void:
	update_walking_timer(delta)
	MovementNode.velocity.x = move_direction.x * walking_speed
	MovementNode.velocity.z = move_direction.z * walking_speed
	MovementNode.velocity.y += delta * GravityForce
