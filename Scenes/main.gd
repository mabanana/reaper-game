extends Node2D

func _ready():
	#Utils.saveGame()
	#Utils.loadGame()
	pass

func _on_button_2_pressed():
	get_tree().quit() # Replace with function body.


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ControlsList.tscn")
