extends State

class_name DeathState
@export var death_animation: String

func on_enter():
	character.velocity.x = 0
	character.velocity.y = 0
	character.death_sound.play()
	playback.travel(death_animation)


func state_process(delta):
	if character.name_animation_finished == death_animation:
		character.queue_free() 
