extends State

class_name IdleState
@export var move_animation: String


func state_process(delta):
	pass


func on_enter():
	character.velocity.x = 0
	playback.play(move_animation)


#func on_exit():
#	if next_state == get_parent().states["Attack"]:
#		playback.play("Attack")

