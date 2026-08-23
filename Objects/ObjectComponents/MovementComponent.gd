class_name MovementComponent
extends Node

@export var MovementNode: CharacterBody3D
@export var States : Array[NPCObjectAnimationState]
@export var GravityForce := -8.0
var State : NPCObjectAnimationState

func _update_movement(delta: float) -> void:
	pass
