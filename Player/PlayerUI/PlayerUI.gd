extends Control

@onready var SeedLabel = $SeedLabel
@onready var CrossHair = $CrossHair

func change_cross_hair(texture: Texture):
	CrossHair.texture = texture

func update_seed_label(seed):
	SeedLabel.text = "Seed : " + str(seed)
