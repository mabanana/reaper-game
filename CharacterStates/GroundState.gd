extends State


class_name GroundState
@export var jump_velocity: float = -400.0
@export var air_state: State
@export var jump_animation : String = "Jump"
@export var ground_deceleration: int = 100


func state_process(delta):
	if(not character.is_on_floor()):
		next_state = air_state
		if character.velocity.y > 0:
			playback.travel("fall")
	else:
		character.jump_direction = 0
	if character.mob_jump == true:
		jump()
		character.mob_jump = false

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		if character.direction_pressed != 0:
			jump()
			character.jump_direction = character.direction_pressed
			print("GroundState: player running jumps")
		else:
			jump()
			print("GroundState: player jumps")
		$"../../SFX/player_jump".play()
	

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)
