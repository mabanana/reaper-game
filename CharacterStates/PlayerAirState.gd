extends State

class_name AirState
@export var jump_animation: String = "Jump"
var has_double_jumped = false

func state_process(delta):
	if character.is_on_floor():
		next_state = get_parent().states["Ground"]
	if character.velocity.y > 0:
		playback.travel("Fall")

	
func state_input(event: InputEvent):
	if event.is_action_pressed("jump") and not has_double_jumped:
		if Game.gems_collected > 0:
			double_jump()

func double_jump():
	character.jump_sound.play()
	character.velocity.y = character.jump_velocity
	if playback.get_current_node() != jump_animation:
		playback.travel(jump_animation)
	has_double_jumped = true

func on_exit():
	if next_state == get_parent().states["Ground"]:
		has_double_jumped = false
		playback.travel("Move")

