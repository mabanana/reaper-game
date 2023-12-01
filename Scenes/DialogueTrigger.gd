extends Area2D
const Balloon = preload("res://UI/balloon.tscn")

func _on_body_entered(body):
	if body.name == "Player" and body.action_state_machine.current_state.name != "Busy":
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/Debug.dialogue"))
		return


func _on_body_exited(body):
	if body.name == "Player" and body.action_state_machine.current_state.name != "Busy":
		pass # Replace with function body.
