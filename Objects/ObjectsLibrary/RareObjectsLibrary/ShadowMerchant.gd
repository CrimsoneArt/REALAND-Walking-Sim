extends NPCObject

const Symbols = [
	"$",
	"¥",
	"€",
	"₪",
	"₱",
	"⃁",
	"ك",
]

func _on_interactability_component_interacted(PlayerNode: Player) -> void:
	var Symbol = Symbols.pick_random()
	PlayerNode.show_dialouge(Symbol+" "+Symbol+" "+Symbol,2.0)
