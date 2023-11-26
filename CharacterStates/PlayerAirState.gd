extends State

class_name AirState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var jump_velocity : float = -400
@export var jump_animation: String = "Jump"
@export var running_jump_deceleration: int = 5
@export var air_deceleration: int = 100
@export var jump_sound: AudioStreamPlayer
@export var mob_jump_sound: AudioStreamPlayer


var has_double_jumped = false

func state_process(delta):
	if character.mob_jump:
		double_jump()
		character.mob_jump = false
		has_double_jumped = false
		mob_jump_sound.play()
	elif character.is_on_floor():
		next_state = state_dict["Ground"]
	if character.velocity.y > 0:
		playback.travel("Fall")

	
func state_input(event: InputEvent):
	if event.is_action_pressed("jump") and not has_double_jumped:
		if Game.gems_collected > 0:
			double_jump()

func double_jump():
	jump_sound.play()
	character.velocity.y = jump_velocity
	if playback.get_current_node() != jump_animation:
		playback.travel(jump_animation)
	has_double_jumped = true

func on_exit():
	if next_state == ground_state:
		has_double_jumped = false
		playback.travel("Move")

