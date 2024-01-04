extends State

class_name AttackState
@export var attack_animation: String = "Attack"

func state_process(delta):
	if character.name_animation_finished == attack_animation:
		next_state = get_parent().states["Idle"]

func on_enter():
	playback.travel(attack_animation)
	character.deal_damage(character.atk_target)
#	var direction = (Game.player_global_position - character.global_position).normalized()
#	character.velocity.x += direction.x * -character.speed*3
#	character.velocity.y += direction.y * -character.speed*1.5
#	character.move_and_slide()
#	character.velocity = Vector2(0,0)

func on_exit():
	character.name_animation_finished = ""
#	if character.can_atk == true:

