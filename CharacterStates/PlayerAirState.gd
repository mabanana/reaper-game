extends State

class_name AirState

func state_process(delta):
	if character.is_on_floor():
		next_state = get_parent().states["Ground"]


func on_enter():
	pass

