class_name StaticObject extends StaticBody3D

@export var objectVariablesComponent : ObjectVariablesComponent

func SetObjectVariable(key:String, Value):
	objectVariablesComponent.SetObjectVariable(key, Value)

func GetObjectVariable(key:String):
	return objectVariablesComponent.GetObjectVariable(key)
