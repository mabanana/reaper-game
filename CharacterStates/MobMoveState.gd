extends State

class_name MoveState
@export var move_animation: String


func state_process(delta):
	if character.can_atk:
		next_state = get_parent().states["Attack"]
	

func on_enter():
	playback.travel(move_animation)


func on_exit():
	if next_state == get_parent().states["Attack"]:
		playback.travel("Attack")

