extends NPCObject

func _on_interactability_component_interacted(PlayerNode: Player) -> void:
	if get_node("/root/SceneLoader").Coins > 0:
		get_node("/root/SceneLoader").Coins = 0
		PlayerNode.get_node("PlayerUI").update_coin_counter()
		get_node("/root/SceneLoader").load_regular_scene("res://Scenes/FakeLandScene.tscn")
