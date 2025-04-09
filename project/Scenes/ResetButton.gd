extends Button

func _on_pressed():
	Utils.game_reset()
	Game.reset_state()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
