extends Node2D
@export var restart_button: Button

# Called when the node enters the scene tree for the first time.
func _ready():
	restart_button.pressed.connect(_on_play_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	Utils.game_reset()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
