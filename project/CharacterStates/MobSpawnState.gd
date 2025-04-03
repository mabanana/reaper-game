extends State

class_name SpawnState
@export var spawn_animation: String
var is_spawned = false

func state_process(delta):
	if not is_spawned:
		playback.travel(spawn_animation)
		is_spawned = true
	if character.name_animation_finished == spawn_animation:
		next_state = get_parent().states["Idle"]
		
func on_enter():
	pass

func on_exit():
	#	character.name_animation_finished = ""
		playback.travel("Move")
