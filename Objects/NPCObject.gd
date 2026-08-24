class_name NPCObject extends GameObject

@export var MovementNode : CharacterBody3D

@export var ActiveComponent: MovementComponent

@onready var NavigationAgent: NavigationAgent3D = $CharacterBody3D/NavigationAgent3D

func _ready() -> void:
	if ActiveComponent:
		ActiveComponent.MovementNode = MovementNode

func _physics_process(delta: float) -> void:
	if not ActiveComponent:
		return
	
	ActiveComponent._update_movement(delta)
	
	MovementNode.move_and_slide()
