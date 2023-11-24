extends State

class_name SpawnState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var move_state: State
@export var spawn_animation: String
@export var spawn_sound: AudioStreamPlayer2D
var is_spawned = false

func state_process(delta):
	if not is_spawned:
		playback.travel(spawn_animation)
	if character.name_animation_finished == spawn_animation:
		next_state = move_state

func on_enter():
	pass

func on_exit():
	pass
