extends Node2D


var cherry = preload("res://cherry.tscn")


func _on_timer_timeout():
	var cherry_temp = cherry.instantiate()
	var rng =RandomNumberGenerator.new()
	var rand_int_x = rng.randi_range(100, 1150)
	var rand_int_y = rng.randi_range(150, 250)
	cherry_temp.position = Vector2(rand_int_x,rand_int_y)
	add_child(cherry_temp)
