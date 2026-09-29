extends NPCObject


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CharacterBody3D/AnimatedSprite3D.play(str(objectVariablesComponent.GetObjectVariable("Type")))
