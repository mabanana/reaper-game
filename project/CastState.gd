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
	await get_tree().create_timer(0.9).timeout
	character.cast_sound_2.play()
	

func state_process(delta):
	pass
