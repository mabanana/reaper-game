extends State


class_name FloatState

func on_enter():
	character.velocity.y = 0
	character.velocity.x = 0
	playback.travel("Float")


func state_process(delta):
	if character.is_float == false:
		next_state = get_parent().states["Idle"]
	character.velocity.x = move_toward(character.velocity.x, 0, character.speed/60)
	character.velocity.y = move_toward(character.velocity.y, 0, character.speed/60)
