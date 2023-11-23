extends State

class_name DummyState
@export var spawn_state: State


func state_process(delta):
	next_state = spawn_state
