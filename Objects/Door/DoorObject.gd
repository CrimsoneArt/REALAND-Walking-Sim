class_name DoorObject extends StaticObject

@export var StartingSeed := 0

func _ready() -> void:
	if objectVariablesComponent.GetObjectVariable("Seed") == null:
		objectVariablesComponent.SetObjectVariable("Seed",StartingSeed)

func _on_interactability_component_interacted() -> void:
	get_node("/root/SceneLoader").load_dimension_scene(objectVariablesComponent.GetObjectVariable("Seed"))
