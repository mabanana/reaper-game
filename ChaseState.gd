extends State

class_name ChaseState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var idle_state: State
@export var attack_state: State
@export var speed : int = 150
@export var run_animation: String = "Jump"


func state_process(delta):
	
	var direction: Vector2
	character.player = character.get_node("../../Player/Player")
	
	if not character.wander:
		direction = (character.player.global_position - character.global_position).normalized()
	elif not anim.flip_h:
		direction.x = 1
	else:
		direction.x = -1


	if direction.x >= 0.5:
		character.velocity.x = direction.x + speed
		anim.play("Jump")
		anim.flip_h = true
	elif direction.x <= -0.5:
		character.velocity.x = direction.x - speed
		anim.play("Jump")
		anim.flip_h = false		

	if not character.is_on_floor():
		character.velocity.y += gravity * delta
	character.move_and_slide()
	



func on_exit():
	pass



func _on_player_detection_body_exited(body):
	if body.name == "Player":
		next_state = idle_state


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		next_state = attack_state
