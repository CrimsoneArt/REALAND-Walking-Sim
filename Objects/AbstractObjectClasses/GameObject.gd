@abstract class_name GameObject extends Node3D

@export var objectVariablesComponent : ObjectVariablesComponent
@export var amount_min := 0
@export var amount_max := 0
@export_range(0.0, 100.0, 0.001, "suffix:%") var ChanceOfAppearing = 100.0

func _ready() -> void:
	if amount_max == 0 or amount_min == 0:
		print("AmountMax and AmountMin have not been properly set, might result in object : " + str(get_script().resource_path.get_file()) + "not spawning.")

func SetObjectVariable(key:String, Value):
	if objectVariablesComponent != null:
		objectVariablesComponent.SetObjectVariable(key, Value)

func GetObjectVariable(key:String):
	if objectVariablesComponent != null:
		return objectVariablesComponent.GetObjectVariable(key)
	else:
		return

func GenerateRandomVariableDictionary(RNG: RandomNumberGenerator) -> Dictionary:
	var Generated := {}
	if objectVariablesComponent != null:
		for Rule in objectVariablesComponent.VariableRules:
			if Rule and not Rule.variable_name.is_empty():
				Generated[Rule.variable_name] = Rule.generate(RNG)
		return Generated
	else:
		return {}

func SetRandomVariables(RNG: RandomNumberGenerator):
	var Generated = GenerateRandomVariableDictionary(RNG)
	for VariableKey in Generated:
		objectVariablesComponent.SetObjectVariable(VariableKey,Generated[VariableKey])
