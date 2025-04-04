extends State


class_name BusyState

func on_enter():
	playback.play("Idle")


func state_process(delta):
	character.velocity.x = 0
