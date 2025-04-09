extends Node2D
class_name Main

@export var play_button: Button
@export var controls_button: Button
@export var quit_button: Button


func _ready():
	#Utils.saveGame()
	#Utils.loadGame()
	play_button.pressed.connect(_on_play_pressed)
	controls_button.pressed.connect(_on_control_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/end_scene.tscn")


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")

func _on_control_pressed():
	get_tree().change_scene_to_file("res://Scenes/ControlsList.tscn")
