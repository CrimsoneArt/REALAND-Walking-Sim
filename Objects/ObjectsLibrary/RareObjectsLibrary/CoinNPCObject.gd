extends NPCObject

var frames = [1,1,2,3,2]
var frame = 0

func _on_timer_timeout() -> void:
	$CharacterBody3D/MeshInstance3D.material_override.albedo_texture = load("res://Objects/ObjectsLibrary/RareObjectsLibrary/CoinNPCBall"+str(frames[frame])+".png")
	frame += 1
	frame = frame % frames.size()
