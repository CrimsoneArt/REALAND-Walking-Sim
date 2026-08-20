class_name ObjectVariableRule extends Resource

enum Type { FLOAT, INT, BOOL, COLOR_RANGE, VECTOR3_RANGE, STRING_ARRAY }

@export var variable_name: String = ""
@export var type: Type = Type.FLOAT

@export_group("Numeric / Vector Ranges")
@export var min_float: float = 0.0
@export var max_float: float = 1.0
@export var min_int: int = 0
@export var max_int: int = 10
@export var min_vector3: Vector3 = Vector3.ZERO
@export var max_vector3: Vector3 = Vector3.ONE

@export_group("Color Range")
@export var min_color: Color = Color.BLACK
@export var max_color: Color = Color.WHITE

@export_group("String Choices")
@export var string_options: Array[String] = []

func generate(rng: RandomNumberGenerator):
	match type:
		Type.FLOAT:
			return rng.randf_range(min_float, max_float)
		Type.INT:
			return rng.randi_range(min_int, max_int)
		Type.BOOL:
			return rng.randf() > 0.5
		Type.COLOR_RANGE:
			return Color(
				rng.randf_range(min_color.r, max_color.r),
				rng.randf_range(min_color.g, max_color.g),
				rng.randf_range(min_color.b, max_color.b),
				rng.randf_range(min_color.a, max_color.a)
			)
		Type.VECTOR3_RANGE:
			return Vector3(
				rng.randf_range(min_vector3.x, max_vector3.x),
				rng.randf_range(min_vector3.y, max_vector3.y),
				rng.randf_range(min_vector3.z, max_vector3.z)
			)
		Type.STRING_ARRAY:
			if string_options.is_empty():
				return ""
			return string_options[rng.randi() % string_options.size()]
	return null
