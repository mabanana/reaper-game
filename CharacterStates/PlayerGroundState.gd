extends State


class_name GroundState

func on_enter():
	if character.is_on_floor():
		character.walk_sound.play()

func state_process(delta):
	if not character.is_on_floor():
		next_state = get_parent().states["Air"]

