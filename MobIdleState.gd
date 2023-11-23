extends State

class_name IdleState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var idle_state: State
@export var idle_animation: String = "Idle"
@export var idle_sound: AudioStreamPlayer2D



func state_process(delta):
	pass

func on_enter():
	character.anim.play(idle_animation)

func on_exit():
	pass


func _on_player_collision_body_entered(body):
	pass # Replace with function body.
