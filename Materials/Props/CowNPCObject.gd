extends NPCObject

var target_right_leg_rotation := 0.0
var target_left_leg_rotation := 0.0
var t := 0.0

func _process(delta: float) -> void:
	if ActiveComponent.State.State == 1:
		t += delta
		target_right_leg_rotation = sin(t)
		target_left_leg_rotation = sin(t+PI)
		$CharacterBody3D/CSGCombiner3D/Leg4.rotation.z = target_right_leg_rotation
		$CharacterBody3D/CSGCombiner3D/Leg2.rotation.z = target_right_leg_rotation
		$CharacterBody3D/CSGCombiner3D/Leg3.rotation.z = target_left_leg_rotation
		$CharacterBody3D/CSGCombiner3D/Leg1.rotation.z = target_left_leg_rotation
	else:
		$CharacterBody3D/CSGCombiner3D/Leg4.rotation.z = lerp($CharacterBody3D/CSGCombiner3D/Leg4.rotation.z,0.0,delta)
		$CharacterBody3D/CSGCombiner3D/Leg2.rotation.z = lerp($CharacterBody3D/CSGCombiner3D/Leg2.rotation.z,0.0,delta)
		$CharacterBody3D/CSGCombiner3D/Leg3.rotation.z = lerp($CharacterBody3D/CSGCombiner3D/Leg3.rotation.z,0.0,delta)
		$CharacterBody3D/CSGCombiner3D/Leg1.rotation.z = lerp($CharacterBody3D/CSGCombiner3D/Leg1.rotation.z,0.0,delta)
