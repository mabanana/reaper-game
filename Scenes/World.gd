extends Node2D


func _on_area_2d_body_entered(body):
	if body.name == "Player" and body.action_state_machine.current_state.name != "Busy":
		body.action_state_machine.current_state.next_state = body.action_state_machine.states["Busy"]
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/PetFound.dialogue"))
		await DialogueManager.dialogue_ended
		body.action_state_machine.current_state.next_state = body.action_state_machine.states["Idle"]
		Game.pet_acquired = true
