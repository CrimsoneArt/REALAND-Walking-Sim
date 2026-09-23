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
	"Xolotl",
	"Land",
	"Fake",
	"Real",
	"Have",
]

func _on_interactability_component_interacted(PlayerNode: Player) -> void:
	var dialouge_text = ""
	for i in range(1,randi_range(2,12)):
		dialouge_text = dialouge_text + " " + Words.pick_random()
	var dialouge = DialougeText.new()
	dialouge.Dialouge = dialouge_text
	dialouge.Duration = 10.0
	PlayerNode.show_dialouge(dialouge)
