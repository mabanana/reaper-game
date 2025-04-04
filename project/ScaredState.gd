extends State

class_name ScaredState
@export var scared_animation: String


func state_process(delta):
	pass


func on_enter():
	playback.play(scared_animation)

