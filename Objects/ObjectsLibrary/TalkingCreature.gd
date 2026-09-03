extends NPCObject

const Words = [
	"Death",
	"Love",
	"Moon",
	"Sun",
	"Bored",
	"Kill",
	"Hate",
	"Happy",
	"Smile",
	"Snow",
	"Man",
	"Bird",
	"Start",
	"End",
	"We",
	"I",
	"You",
	"Land",
	"Fake",
	"Real",
]

func _on_interactability_component_interacted(PlayerNode: Player) -> void:
	var dialouge_text = ""
	for i in range(1,randi_range(2,12)):
		dialouge_text = dialouge_text + " " + Words.pick_random()
	PlayerNode.show_dialouge(dialouge_text,10.0)
