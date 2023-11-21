extends Node2D

signal child_spawned ()
var cherry = preload("res://cherry.tscn")
var msg = preload("res://player_message.tscn")

func spawn_cherry(int_x, int_y):
	var cherry_temp = cherry.instantiate()
	cherry_temp.position = Vector2(int_x,int_y)
	add_child(cherry_temp)

func _on_timer_timeout():
	
	var rng =RandomNumberGenerator.new()
	var rand_int_x = rng.randi_range(100, 1150)
	var rand_int_y = rng.randi_range(150, 250)
	spawn_cherry(rand_int_x,rand_int_y)
#	var cherry_temp = cherry.instantiate()
#	cherry_temp.position = Vector2(rand_int_x,rand_int_y)
#	add_child(cherry_temp)

func _on_gem_body_entered(body):
	if body.name == "Player":
		var msg_temp = msg.instantiate()
		msg_temp.position = self.global_position
		$"../UI".add_child(msg_temp)


func _on_mobs_child_exiting_tree(node):
	for i in RandomNumberGenerator.new().randi_range(2,3):
		print(i)
		spawn_cherry(node.position.x + (10*i), node.position.y  - (10*i))
		await self.child_spawned


func _on_child_entered_tree(node):
	print("cherry spawned")
	self.child_spawned
