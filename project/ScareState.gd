extends State
class_name ScareState

func on_enter():
	character.velocity.x = 0
	playback.play("Scare")
	
func state_process(delta):
	if character.name_animation_finished == "Scare":
		next_state = get_parent().states["Idle"] 
	character.name_animation_finished = ""
