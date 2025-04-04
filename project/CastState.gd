extends State

class_name CastState
@export var cast_animation: String

func on_enter():
	playback.play(cast_animation)
	playback.animation_finished.connect(func(anim_name):
		if anim_name == cast_animation:
			next_state = get_parent().states["Idle"]
	)
	character.cast_sound.play()

func state_process(delta):
	pass
