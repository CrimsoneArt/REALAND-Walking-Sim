class_name StaticObject extends StaticBody3D

@export var objectVariablesComponent : ObjectVariablesComponent

func SetObjectVariable(key:String, Value):
	objectVariablesComponent.SetObjectVariable(key, Value)

func GetObjectVariable(key:String):
	return objectVariablesComponent.GetObjectVariable(key)

func GenerateRandomVariableDictionary(RNG: RandomNumberGenerator) -> Dictionary:
	var Generated := {}
	for Rule in objectVariablesComponent.VariableRules:
		if Rule and not Rule.variable_name.is_empty():
			Generated[Rule.variable_name] = Rule.generate(RNG)
	return Generated

func SetRandomVariables(RNG: RandomNumberGenerator):
	var Generated = GenerateRandomVariableDictionary(RNG)
	for VariableKey in Generated:
		objectVariablesComponent.SetObjectVariable(VariableKey,Generated[VariableKey])
