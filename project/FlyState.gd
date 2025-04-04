extends State

class_name FlyState

func on_enter():
	get_tree().create_timer(character.flight_time).timeout.connect(_on_timer_timeout)


func state_process(delta): 
	pass

func _on_timer_timeout():
	next_state = get_parent().states["Idle"]
	

func on_exit():
	character.velocity = character.velocity.normalized() * character.speed
	for timer in get_children():
		timer.queue_free()
