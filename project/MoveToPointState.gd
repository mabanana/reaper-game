extends State

class_name MoveToPointState
@export var move_animation: String


func state_process(delta):
	pass


func on_enter():
	playback.play(move_animation)
