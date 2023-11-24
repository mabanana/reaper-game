extends Mob

@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D
@export var character_state_machine: CharacterStateMachine

var name_animation_finished: String = ""

func _ready():
	animation_tree.active = true
	
func _physics_process(delta):
	if health <= 0 and character_state_machine.current_state.name != "Death":
		collision_shape.set_deferred("disabled", true)
		character_state_machine.current_state.next_state = character_state_machine.current_state.death_state
	# Send parameter data to CharacterStateMachine
	character_state_machine.state_machine_process(delta)
	var blend_position: Vector2
	# Moves the chatacter based on input if state allows movement
	if character_state_machine.current_state.can_move:
#		animation_tree["parameters/Move/blend_position"] = (Vector2(0, 0))
		# Calculate the direction towards the player for chasing
		if chase:
			var direction = (Game.player_global_position - global_position).normalized()
			if direction.x >= 0.5:
				velocity.x = direction.x + speed
				sprite_2d.flip_h = true
			elif direction.x <= -0.5:
				velocity.x = direction.x - speed
				sprite_2d.flip_h = false
			blend_position.x = velocity.x
		else:
			velocity.x = 0
	else:
		if character_state_machine.current_state.name == "Attack":
			velocity.x = move_toward(velocity.x, 0, speed/3)
		else:
			velocity.x = 0
		#Adds gravity to mobs if not on the floor
	if not is_on_floor() and character_state_machine.current_state.has_gravity == true:
		velocity.y += gravity * delta
		blend_position.y = velocity.y
		blend_position = blend_position.normalized()
		if blend_position.y == 1:
			blend_position.x = 0
	else:
		velocity.y = 0

	# Sends movement data to the animation tree
	animation_tree.set("parameters/Move/blend_position", blend_position)
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player": 
		chase = true
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false



func _on_player_collision_body_entered(body):
	if body.name == "Player":
		can_atk = true
func _on_player_collision_body_exited(body):
	if body.name == "Player":
		can_atk = false
	


func _on_frog_animation_tree_animation_finished(anim_name):
	name_animation_finished = anim_name



func _on_animation_tree_animation_started(anim_name):
	pass


func _on_asd_animation_tree_animation_finished(anim_name):
	name_animation_finished = anim_name
