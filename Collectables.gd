extends Node2D

var cherry = preload("res://cherry.tscn")
var gem = preload("res://Gem.tscn")
var msg = preload("res://UI/player_message.tscn")


func _ready():
	var gem_temp = gem.instantiate()
	gem_temp.position = Vector2(724,560)
	add_child(gem_temp)
	var gem_temp2 = gem.instantiate()
	gem_temp2.position = Vector2(641,147)
	add_child(gem_temp2)
	pass

func spawn_cherry(int_x, int_y):
	var cherry_temp = cherry.instantiate()
	cherry_temp.position = Vector2(int_x,int_y)
	add_child(cherry_temp)

func _on_timer_timeout():
	pass
#	var rng =RandomNumberGenerator.new()
#	var rand_int_x = rng.randi_range(100, 1150)
#	var rand_int_y = rng.randi_range(150, 250)
#	spawn_cherry(rand_int_x,rand_int_y)
#	var cherry_temp = cherry.instantiate()
#	cherry_temp.position = Vector2(rand_int_x,rand_int_y)
#	add_child(cherry_temp)

#func _on_gem_body_entered(body):
#	if body.name == "Player":
#		print("Collectables: display message for " + str(Game.gems_collected) + " gem.")
#		var msg_temp = msg.instantiate()
#		msg_temp.position = self.global_position
#		$"../UI".add_child(msg_temp)


func _on_mobs_child_exiting_tree(node):
	var mob_position = node.position
	var mob_name = str(node.name)
	for i in RandomNumberGenerator.new().randi_range(node.drop_amount, node.drop_amount + node.drop_range):
		var rng = RandomNumberGenerator.new().randi_range(-10,10)
		spawn_cherry(mob_position.x + (rng), mob_position.y)
		print("Collectables: " + mob_name + " drops 1 cherry")
		$"../Timers/Timer".start(0.15)
		await $"../Timers/Timer".timeout


func _on_child_exiting_tree(node):
	if node.id == "Gem":
		print("Collectables: display message for " + str(Game.gems_collected) + " gem.")
		var msg_temp = msg.instantiate()
		msg_temp.position = self.global_position
		$"../UI".add_child(msg_temp)
