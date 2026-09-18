extends Node3D

var target_train_x_position = 10.75

func _ready() -> void:
	if get_node("/root/SceneLoader") != null:
		get_node("/root/SceneLoader").stop_music() #dont forget to delete this when music system is reworked

func _on_interactability_component_interacted(PlayerNode: Player) -> void:
	if $Train.position.x <= 10.75:
		target_train_x_position = 33.5
		$TrainTimer.start()
	elif $Train.position.x >= 57.0:
		$Train.position.x = 10.75
		target_train_x_position = 33.5
	else:
		get_node("/root/SceneLoader").load_dimension_scene(randi())
	
func _process(delta: float) -> void:
	$Train.position = lerp($Train.position,Vector3(target_train_x_position,$Train.position.y,$Train.position.z),delta)

func _on_train_timer_timeout() -> void:
	target_train_x_position = 70.5
