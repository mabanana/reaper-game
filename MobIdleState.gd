extends State

class_name IdleState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var chase_state: State
@export var idle_animation: String = "Idle"
@export var idle_sound: AudioStreamPlayer2D

var player_direction: int



func state_process(delta):
	pass

func on_enter():
	character.anim.play(idle_animation)

func on_exit():
	pass


func _on_player_detection_body_entered(body):
	print("FrogIdleState: " + body.name+ " has entered the player detection")
	if body.name == "Player": 
		next_state = chase_state
