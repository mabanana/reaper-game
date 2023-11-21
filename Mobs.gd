extends Node2D

var frog = preload("res://frog.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	print("spawn frog")
	var frog_temp = frog.instantiate()
	var rng = RandomNumberGenerator.new()
	var rand_int_x = rng.randi_range(850, 1150)
	var rand_int_y = rng.randi_range(300, 310)
	frog_temp.position = Vector2(rand_int_x,rand_int_y)
	add_child(frog_temp)# Replace with function body.