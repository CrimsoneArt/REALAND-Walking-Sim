extends StaticObject

func _ready() -> void:
	$CSGCombiner3D/CSGBox3D.size.y = objectVariablesComponent.GetObjectVariable("Height")
