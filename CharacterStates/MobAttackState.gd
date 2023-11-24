extends State

class_name AttackState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var move_state: State
@export var attack_animation: String = "Attack"
@export var attack_sound: AudioStreamPlayer2D



func state_process(delta):
	if character.name_animation_finished == attack_animation:
		next_state = move_state

func on_enter():
#	playback.travel(attack_animation)
	attack_sound.play()
	Game.player_hp -= character.attack_damage
	print("Frog: frog deals " + str(character.attack_damage) + " to player")
	var direction = (Game.player_global_position - character.global_position).normalized()
	character.velocity.x += direction.x * -character.speed*3
	character.velocity.y += direction.y * -character.speed*1.5
	character.move_and_slide()
#	character.velocity = Vector2(0,0)

func on_exit():
	character.name_animation_finished = ""
#	if character.can_atk == true:

