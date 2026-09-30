class_name DoorObject extends GameObject

signal opened

func _ready() -> void:
	$StaticBody3D/Sprite3D.texture = load("res://Objects/Door/DoorSprites/Door"+str(objectVariablesComponent.GetObjectVariable("SpriteNumber"))+".png")
	$StaticBody3D/Sprite3D.pixel_size = objectVariablesComponent.GetObjectVariable("SpriteHeight")/$StaticBody3D/Sprite3D.texture.get_size().y
	$StaticBody3D.position.y = $StaticBody3D/Sprite3D.texture.get_size().y*$StaticBody3D/Sprite3D.pixel_size*0.5

func _on_interactability_component_interacted(PlayerNode: Player) -> void:
	
	get_node("/root/SceneLoader").load_dimension_scene(objectVariablesComponent.GetObjectVariable("Seed"))
	emit_signal("opened")
