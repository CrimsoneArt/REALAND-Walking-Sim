extends NPCObject

func _ready() -> void:
	$CharacterBody3D/AnimatedSprite3D.play(str(objectVariablesComponent.GetObjectVariable("NeonID")))
	$CharacterBody3D/InteractabilityComponent.SoundEffect = load("res://SFX/NeonCreature"+str(objectVariablesComponent.GetObjectVariable("NeonID"))+".mp3")
