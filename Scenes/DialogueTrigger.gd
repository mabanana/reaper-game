extends Area2D
const Balloon = preload("res://UI/balloon.tscn")

func _on_body_entered(body):
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/TestDialogue.dialogue"))
	return
