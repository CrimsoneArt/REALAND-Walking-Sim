extends NPCObject

func _ready() -> void:
	$CharacterBody3D/AnimatedSprite3D.play(str(objectVariablesComponent.GetObjectVariable("Type")))
