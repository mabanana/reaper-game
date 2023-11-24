extends State

class_name AttackState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var idle_state: State
@export var chase_state: State
@export var attack_animation: String = "Attack"
@export var attack_sound: AudioStreamPlayer2D
@export var attack_damage: int




func state_process(delta):
	Game.player_hp -= attack_damage
	attack_sound.play()
	var direction = (Game.player_global_position - character.global_position).normalized()
	character.velocity.x += direction.x * -1200
	character.velocity.y += direction.y * -100
#	move_and_collide(velocity)
	character.move_and_slide()
	print("Frog: frog deals " + str(attack_damage) + " to player")
	next_state = chase_state

func on_enter():
	attack_damage = character.attack_damage

func on_exit():
	pass


func _on_player_collision_body_exited(body):
	if body.name == "Player":
		next_state = chase_state
