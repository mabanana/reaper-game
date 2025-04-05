extends Area2D
class_name RectDialogueTrigger

@export var trigger_condition: bool = true
@export var is_one_time: bool

func _on_body_entered(body):
	if body.name == "Player" and body.action_state_machine.current_state.name != "Busy" and trigger_condition:
		body.action_state_machine.current_state.next_state = body.action_state_machine.states["Busy"]
		body.action_state_machine.current_state.next_state = body.action_state_machine.states["Idle"]
		if is_one_time:
			queue_free()
		return


func _on_body_exited(body):
	if body.name == "Player" and body.action_state_machine.current_state.name != "Busy":
		pass
