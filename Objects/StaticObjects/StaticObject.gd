class_name StaticObject extends StaticBody3D

@export var ObjectVariablesComponent : ObjectVariablesComponent

func SetObjectVariable(key:String, Value):
	ObjectVariablesComponent.Variables[key] = Value

func GetObjectVariable(key:String):
	if ObjectVariablesComponent.Variables.has(key):
		return ObjectVariablesComponent.Variables[key]
	else:
		return null

#dijushgfiuoshd
