extends State

class_name DeathState
@export var death_animation: String

func on_enter():
	character.velocity = Vector2(0,0)
	playback.play(death_animation)


func state_process(delta):
	if character.name_animation_finished == death_animation:
		character.die()
