extends NPCObject

const Lines = [
	"Hello? What do you want from me?",
	"Leave me alone",
	"Get lost",
	"Do you need something?",
	"Please get away"
]

func _on_interactability_component_interacted(PlayerNode: Player) -> void:
	PlayerNode.show_dialouge(Lines.pick_random(),3.5,true)
