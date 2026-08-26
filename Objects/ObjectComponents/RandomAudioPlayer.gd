extends AudioStreamPlayer3D

@export var SoundEffects : Array[AudioStream]
@export var MinPitch := 0.5
@export var MaxPitch := 1.5
@export var MinWaitTime := 0.5
@export var MaxWaitTime := 1.5

var timer := Timer.new()

func _ready() -> void:
	timer.one_shot = true
	timer.wait_time = randf_range(MinWaitTime,MaxWaitTime)
	timer.timeout.connect(play_sfx)
	add_child(timer)
	timer.start()

func play_sfx():
	pitch_scale = randf_range(MinPitch,MaxPitch)
	stream = SoundEffects.pick_random()
	play()
	timer.wait_time = randf_range(MinWaitTime,MaxWaitTime)
	timer.start()
