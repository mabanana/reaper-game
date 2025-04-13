extends Node2D

var cherry = preload("res://cherry.tscn")

func spawn_cherry(int_x, int_y):
	var cherry_temp = cherry.instantiate()
	cherry_temp.position = Vector2(int_x,int_y)
	add_child(cherry_temp)

func _on_mobs_child_exiting_tree(node):
	var mob_position = node.position
	var mob_name = str(node.name)
	# Bandaid fix for scene switching
	if not get_tree():
		return
	for i in RandomNumberGenerator.new().randi_range(node.drop_amount, node.drop_amount + node.drop_range):
		var rng = RandomNumberGenerator.new().randi_range(-10,10)
		spawn_cherry(mob_position.x + (rng), mob_position.y)
		await get_tree().create_timer(0.15).timeout
		print("Collectables: " + mob_name + " drops 1 cherry")

func _on_child_exiting_tree(node):
	if node.id == "Gem":
		Game.show_player_msg = true
		print("Collectables: display message for " + str(Game.gems_collected) + " gem.")
