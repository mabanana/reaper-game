extends State

class_name MoveState
@export var move_animation: String


func state_process(delta):
	pass


func on_enter():
	character.velocity.x = 0
	playback.travel(move_animation)


#func on_exit():
#	if next_state == get_parent().states["Attack"]:
#		playback.travel("Attack")

