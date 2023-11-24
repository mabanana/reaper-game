extends State

class_name DeathState
@export var death_animation: String
@export var death_sound: AudioStreamPlayer2D

func on_enter():
	death_sound.play()
	playback.travel(death_animation)


func state_process(delta):
	if playback.get_current_node() == "End":
		character.queue_free() 
