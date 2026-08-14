class_name ObjectSpawner extends Node

var RNG = RandomNumberGenerator.new()

func spawn_object(Seed:int,Scene:String,Position:Vector3,ObjectVariables:={}):
	RNG.seed = Seed
	var ObjectScene = load(Scene)
	var ObjectNode = ObjectScene.instantiate()
	if ObjectNode is StaticObject:
		ObjectNode.position = Position
		ObjectNode.rotation_degrees.y = RNG.randf_range(-360,360)
		for key in ObjectVariables:
			ObjectNode.SetObjectVariable(key,ObjectVariables[key])
	get_parent().add_child(ObjectNode)
