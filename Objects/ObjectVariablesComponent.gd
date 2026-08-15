class_name ObjectVariablesComponent extends Node

@export var Variables := {}

func SetObjectVariable(key:String, Value):
	Variables[key] = Value

func GetObjectVariable(key:String):
	if Variables.has(key):
		return Variables[key]
	else:
		return null

func GetObjectVariables() -> Dictionary:
	return Variables
