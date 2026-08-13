class_name Door extends Area3D

@export var seed := 0
@onready var SeedDisplayer = $Label3D

func _ready() -> void:
	SeedDisplayer.text = "Seed : " + str(seed) 
