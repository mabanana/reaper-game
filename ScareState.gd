extends State
class_name ScareState

func on_enter():
	character.velocity.x = 0
	playback.travel("Scare")
	character.scare_sound.play()
	
func state_process(delta):
	if character.name_animation_finished == "Scare":
		next_state = get_parent().states["Idle"] 
	character.name_animation_finished = ""
