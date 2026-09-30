class_name WanderComponent extends MovementComponent

@export var min_walk_time: float = 1.0
@export var max_walk_time: float = 3.0
@export var min_wait_time: float = 1.0
@export var max_wait_time: float = 3.0
@export var walking_speed: float = 3.0

var move_direction: Vector3 = Vector3.ZERO
var is_waiting: bool = false
var walking_timer: float = 0.0

func _ready() -> void:
	start_walking()

func _update_movement(delta: float):
	update_walking_timer(delta)
	
	MovementNode.velocity = move_direction * walking_speed
	MovementNode.velocity.y = GravityForce

func update_walking_timer(delta):
	walking_timer -= delta
	
	if walking_timer <= 0:
		if is_waiting:
			start_walking()
		else:
			start_waiting()

func start_walking() -> void:
	is_waiting = false
	walking_timer = randf_range(min_walk_time, max_walk_time)
	var angle = randf_range(0, TAU)
	State = States[1]
	
	move_direction = Vector3(cos(angle), 0, sin(angle)).normalized()
	MovementNode.look_at(MovementNode.global_position + move_direction, Vector3.UP)

func start_waiting() -> void:
	is_waiting = true
	walking_timer = randf_range(min_wait_time, max_wait_time)
	move_direction = Vector3.ZERO
	State = States[0]
