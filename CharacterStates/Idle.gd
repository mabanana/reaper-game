extends State


class_name IdleState
@export var death_animation: String

func on_enter():
	if playback.get_current_node() != "Move":
		playback.travel("Move")


func state_process(delta):
	pass 
