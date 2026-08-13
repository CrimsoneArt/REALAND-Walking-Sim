extends Node

func spawn_object(Scene:String,Position:Vector3):
	var ObjectScene = load(Scene)
	var ObjectNode = ObjectScene.instantiate()
	ObjectNode.position = Position
	get_parent().add_child(ObjectNode)
