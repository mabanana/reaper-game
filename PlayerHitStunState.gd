extends State

class_name HitStunState
@export var hurt_animation: String
@export var hurt_sound: AudioStreamPlayer
@export var ground_state: State
@export var air_state: State

func on_enter():
	hurt_sound.play()
	playback.travel(hurt_animation)


func state_process(delta):
	if character.name_animation_finished == hurt_animation:
		if character.is_on_floor():
			next_state = ground_state
		else: 
			next_state = air_state

