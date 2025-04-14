extends Node2D

@export var spawners: Node2D
var frog = preload("res://frog.tscn")

var spawner_dict = {}
var spawn_interval = 15

func _ready():
	init_spawners()
	
func init_spawners():
	for spawner: Marker2D in spawners.get_children():
		if spawner.name.to_lower().contains("frog"):
			spawner_dict[spawner] = spawn_frog(spawner.global_position)
			_on_spawn_timer_timeout(spawner)

func _on_spawn_timer_timeout(spawner: Marker2D):
	if spawner_dict[spawner] == null:
		var new_frog = spawn_frog(spawner.global_position)
		spawner_dict[spawner] = new_frog
	get_tree().create_timer(spawn_interval).timeout.connect(_on_spawn_timer_timeout.bind(spawner))

func spawn_frog(pos: Vector2):
	var frog_temp = frog.instantiate()
	frog_temp.global_position = pos
	add_child(frog_temp)
	print("Frog spawned at %s" % [pos])
	return frog_temp
