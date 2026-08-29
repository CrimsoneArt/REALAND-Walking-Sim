extends MeshInstance3D

func _ready():
	var mat = mesh.material as ShaderMaterial
	var noise_tex = mat.get_shader_parameter("noise_texture") as NoiseTexture2D
	if noise_tex and not noise_tex.is_queued_for_deletion():
		await noise_tex.changed # Wait for the background thread to finish baking
