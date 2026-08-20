class_name DoorObject extends StaticObject

func _on_interactability_component_interacted() -> void:
	get_node("/root/SceneLoader").load_dimension_scene(objectVariablesComponent.GetObjectVariable("Seed"))
