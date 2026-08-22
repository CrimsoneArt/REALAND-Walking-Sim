extends StaticObject

func _ready() -> void:
	$CSGCombiner3D/CSGBox3D.size.y = objectVariablesComponent.GetObjectVariable("Height")
	$CSGCombiner3D/CSGBox3D.material = objectVariablesComponent.MaterialsList[posmod(objectVariablesComponent.GetObjectVariable("MaterialIndex"),objectVariablesComponent.MaterialsList.size())]
