extends Area2D
class_name RectDialogueTrigger

@export var trigger_condition: bool = true
@export var Balloon: Resource = preload("res://UI/balloon.tscn")
@export var dialogue_file: DialogueResource
@export var is_one_time: bool

func _on_body_entered(body):
	if body.name == "Player" and body.action_state_machine.current_state.name != "Busy" and trigger_condition:
		body.action_state_machine.current_state.next_state = body.action_state_machine.states["Busy"]
		DialogueManager.show_dialogue_balloon(dialogue_file)
		await DialogueManager.dialogue_ended
		body.action_state_machine.current_state.next_state = body.action_state_machine.states["Idle"]
		if is_one_time:
			queue_free()
		return


func _on_body_exited(body):
	if body.name == "Player" and body.action_state_machine.current_state.name != "Busy":
		pass
