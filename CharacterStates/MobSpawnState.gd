extends State

class_name SpawnState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var spawn_animation: String
@export var spawn_sound: AudioStreamPlayer2D
var is_spawned = false

func state_process(delta):
	if not is_spawned:
		playback.travel(spawn_animation)
		is_spawned = true
	if character.name_animation_finished == spawn_animation:
		next_state = state_dict["Move"]
		
func on_enter():
	pass

func on_exit():
	character.name_animation_finished = ""
	playback.travel("Move")
