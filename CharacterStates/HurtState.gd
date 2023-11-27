extends State


class_name HurtState
@export var hurt_animation: String

func on_enter():
	playback.travel(hurt_animation)

func state_process(delta): 
	var timer := Timer.new()
	add_child(timer)
	timer.start(character.hit_stun_length)
	timer.connect("timeout", _on_timer_timeout)

func _on_timer_timeout():
	next_state = get_parent().states["Idle"]
