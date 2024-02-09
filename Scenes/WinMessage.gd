extends Label


func _process(delta):
	if Game.gems_collected == 2 and get_node("Mobs").get_child_count() == 1:
		text = "Yay, You Won!"
	
