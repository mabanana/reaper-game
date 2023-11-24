extends State

class_name MoveState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var attack_state: State
@export var move_animation: String


func state_process(delta):
	if character.can_atk:
		next_state = attack_state
	

func on_enter():
	playback.travel(move_animation)


func on_exit():
	if next_state == attack_state:
		playback.travel("Attack")

