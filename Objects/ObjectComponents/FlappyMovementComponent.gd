class_name FlappyMovementComponent extends MovementComponent

@export var min_timer_wait_time := 0.0
@export var max_timer_wait_time := 1.0
@export var jump_strengh := 10.0

var timer := Timer.new()

func _ready() -> void:
	add_child(timer)
	timer.timeout.connect(flap)
	flap()

func flap():
	timer.wait_time = randf_range(min_timer_wait_time,max_timer_wait_time)
	timer.start()
	MovementNode.velocity.y = jump_strengh

func _process(delta: float) -> void:
	MovementNode.velocity.y += delta*GravityForce
