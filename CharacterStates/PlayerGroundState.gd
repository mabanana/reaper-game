extends State


class_name GroundState
@export var jump_velocity: float = -400.0
@export var jump_animation : String = "Jump"
@export var ground_deceleration: int = 100



func on_enter():
	if Input.is_action_pressed("jump"):
		jump()
	if not character.is_on_floor():
		character.walk_sound.play()

func state_process(delta):
	if not character.is_on_floor():
		next_state = state_dict["Air"]
	else:
		character.jump_direction = 0

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		if character.direction_pressed != 0:
			jump()
			character.jump_direction = character.direction_pressed
			print("GroundState: player running jumps")
		else:
			jump()
			print("GroundState: player jumps")

	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		character.walk_sound.play()

func jump():
	character.jump_sound.play()
	character.velocity.y = jump_velocity
	next_state = state_dict["Air"]
	playback.travel(jump_animation)
