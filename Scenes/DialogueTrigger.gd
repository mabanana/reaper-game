extends Area2D
const Balloon = preload("res://UI/balloon.tscn")

func _on_body_entered(body):
	if body.name == "Player" and body.action_state_machine.current_state.name != "Busy":
		body.action_state_machine.current_state.next_state = body.action_state_machine.states["Busy"]
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/Debug.dialogue"))
		await DialogueManager.dialogue_ended
		body.action_state_machine.current_state.next_state = body.action_state_machine.states["Idle"]
		return


func _on_body_exited(body):
	if body.name == "Player" and body.action_state_machine.current_state.name != "Busy":
		pass # Replace with function body.
