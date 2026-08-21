class_name ObjectSpawner extends Node

var DoorScene = preload("res://Objects/Door/DoorObject.tscn")

func spawn_object(RNG,ObjectScene:PackedScene,Position:Vector3,Materials:Array[Material]):
	var ObjectNode = ObjectScene.instantiate()
	if ObjectNode is StaticObject:
		ObjectNode.position = Position
		ObjectNode.rotation_degrees.y = RNG.randf_range(-360,360)
		ObjectNode.SetRandomVariables(RNG)
		ObjectNode.objectVariablesComponent.MaterialsList = Materials
	get_parent().add_child(ObjectNode)
