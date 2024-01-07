extends State

class_name CastState
@export var cast_animation: String

func on_enter():
	playback.travel(cast_animation)
	character.cast_sound.play()

func state_process(delta):
	if character.name_animation_finished == cast_animation:
		next_state = get_parent().states["Idle"]
	character.name_animation_finished = ""
