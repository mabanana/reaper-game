extends State


class_name GroundState
@export var jump_velocity: float = -400.0
@export var air_state: State
@export var jump_animation : String = "Jump"
@export var ground_deceleration: int = 100
@export var jump_sound: AudioStreamPlayer2D
@export var walk_sound: AudioStreamPlayer2D


func on_enter():
	if Input.is_action_pressed("jump"):
		jump()
	pass

func state_process(delta):
	if(not character.is_on_floor()):
		next_state = air_state
	else:
		character.jump_direction = 0


func state_input(event : InputEvent):
	if event.is_action_just_pressed("jump"):
		if character.direction_pressed != 0:
			jump()
			character.jump_direction = character.direction_pressed
			print("GroundState: player running jumps")
		else:
			jump()
			print("GroundState: player jumps")
		jump_sound.play()
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		walk_sound.play()

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)
