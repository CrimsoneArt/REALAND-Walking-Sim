class_name InteractabilityComponent extends Area3D

signal Interacted

func interact():
	emit_signal("Interacted")
