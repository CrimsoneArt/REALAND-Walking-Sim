extends StaticObject

func _ready() -> void:
	$CSGCombiner3D/CSGBox3D.size.y = objectVariablesComponent.GetObjectVariable("Height")

func _generateRandomVariables(seed):
	RNG.seed = seed
	objectVariablesComponent.SetObjectVariable("Height",RNG.randf_range(RNG.randf_range(0,2),RNG.randf_range(8,10)))
