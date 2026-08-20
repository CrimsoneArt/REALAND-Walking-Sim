class_name ObjectSpawner extends Node

var RNG = RandomNumberGenerator.new()
var DoorScene = preload("res://Objects/Door/DoorObject.tscn")

func spawn_object(Seed:int,ObjectScene:PackedScene,Position:Vector3,ObjectVariables:={}):
	RNG.seed = Seed
	var ObjectNode = ObjectScene.instantiate()
	if ObjectNode is StaticObject:
		ObjectNode.position = Position
		ObjectNode.rotation_degrees.y = RNG.randf_range(-360,360)
		for key in ObjectVariables:
			ObjectNode.SetObjectVariable(key,ObjectVariables[key])
		if ObjectVariables == {}:
			ObjectNode._generateRandomVariables(Seed)
	get_parent().add_child(ObjectNode)
