class_name ObjectSpawner extends Node

var DoorScene = preload("res://Objects/Door/DoorObject.tscn")

func spawn_object(RNG,ObjectScene:PackedScene,Position:Vector3):
	var ObjectNode = ObjectScene.instantiate()
	if ObjectNode is StaticObject:
		ObjectNode.position = Position
		ObjectNode.rotation_degrees.y = RNG.randf_range(-360,360)
		ObjectNode.SetRandomVariables(RNG)
		
	get_parent().add_child(ObjectNode)
