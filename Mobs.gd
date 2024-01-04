extends Node2D

var frog = preload("res://frog.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _on_spawn_timer_timeout():
#	var rng = RandomNumberGenerator.new()
#	var rand_int_x = rng.randi_range(850, 1150)
#	var int_y = 310
#	spawn_frog(Vector2(rand_int_x,int_y))# Replace with function body.

func spawn_frog(spawn_position: Vector2):
	var frog_temp = frog.instantiate()
	frog_temp.position = spawn_position
	add_child(frog_temp)
