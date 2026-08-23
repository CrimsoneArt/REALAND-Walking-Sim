class_name NPCObjectAnimationStatePlayerComponent extends AnimatedSprite3D

@export var movementComponent : MovementComponent
var PreviousState : NPCObjectAnimationState

func _process(delta: float) -> void:
	if PreviousState != movementComponent.State:
		play(movementComponent.State.States.find_key(movementComponent.State.State))
