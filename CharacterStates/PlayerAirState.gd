extends State

class_name AirState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var ground_state: State
@export var jump_velocity : float = -400
@export var jump_animation: String = "Jump"
@export var running_jump_deceleration: int = 5
@export var air_deceleration: int = 100

var has_double_jumped = false

func state_process(delta):
	character.velocity.y += gravity * delta
	if character.is_on_floor():
		next_state = ground_state
	if character.velocity.y > 0:
		playback.travel("Fall")

	
func state_input(event: InputEvent):
	if event.is_action_pressed("jump") and not has_double_jumped:
		if Game.gems_collected > 0:
			double_jump()


func double_jump():
	$"../../SFX/player_jump".play()
	character.velocity.y = jump_velocity
	if playback.get_current_node() != jump_animation:
		playback.travel(jump_animation)
	has_double_jumped = true

func on_exit():
	if next_state == ground_state:
		has_double_jumped = false
		playback.travel("Move")


func _on_mob_collision_body_entered(body):
	print("AirState: " + "player landed on a body " + str(body.name))
	if body.get_parent().name == "Mobs" and character.velocity.y >= 0 and character.player_alive:
#		character.mob_jump = true
		body.health -= character.jump_damage + int(character.jump_damage + character.velocity.y / 100)
		print("Air State: " + "player dealt " + str(int(character.jump_damage * character.velocity.y / 100)) + " to a " + str(body.name))
		$"../../SFX/player_land_on_mob".play()
		double_jump()
		has_double_jumped = false
