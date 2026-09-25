extends GameObject

func _ready() -> void:
	$AnimatedSprite3D.play(str(objectVariablesComponent.GetObjectVariable("Sprite")))
	
	var RNG = RandomNumberGenerator.new()
	RNG.seed = objectVariablesComponent.Seed
	var colorMin = Color(RNG.randf_range(0.0,1.0),RNG.randf_range(0.0,1.0),RNG.randf_range(0.0,1.0),1.0)
	var colorMax = Color(RNG.randf_range(0.0,1.0),RNG.randf_range(0.0,1.0),RNG.randf_range(0.0,1.0),1.0)
	var color = colorMax.lerp(colorMin,objectVariablesComponent.GetObjectVariable("ColorLerpAmount"))
	$AnimatedSprite3D.modulate = color
