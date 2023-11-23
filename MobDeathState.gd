extends State

class_name DeathState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var idle_state: State
@export var death_animation: String = "Jump"
@export var death_sound: AudioStreamPlayer2D



func _process(delta):
	pass
