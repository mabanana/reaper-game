extends Mob
class_name Frog

const position_snap_range: int = 2
@export var death_sound: AudioStreamPlayer
@export var attack_sound: AudioStreamPlayer

var chase_distance: int
var chase_location: Vector2
var position_mtp: Vector2
var atk_target


func _ready():
	chase_location = global_position
	
func _physics_process(delta):
#	if health <= 0 and character_state_machine.current_state.name != "Death":
#		collision_shape.set_deferred("disabled", true)
#		character_state_machine.current_state.next_state = character_state_machine.states["Death"]

	# Send parameter data to CharacterStateMachine
	character_state_machine.state_machine_process(delta)
	
	# Moves the chatacter based on input if state allows movement
	if character_state_machine.current_state.can_move:
#		animation_tree["parameters/Move/blend_position"] = (Vector2(0, 0))
		# Calculate the direction towards the player for chasing

		var direction = (chase_location - global_position).normalized()
		

		if direction.x >= 0.5:
			velocity.x = direction.x + speed
			sprite_2d.flip_h = true
		elif direction.x <= -0.5:
			velocity.x = direction.x - speed
			sprite_2d.flip_h = false
		else:
			velocity.x = 0
		blend_position.x = velocity.x

		#Adds gravity to mobs if not on the floor
	if not is_on_floor() and current_state().has_gravity:
		velocity.y += gravity * delta
		blend_position.y = velocity.y
		blend_position = blend_position.normalized()
		blend_position.x = 0
	else:
		velocity.y = 0

	if current_state().name == "MoveToPoint":
		if velocity.x == 0 or (chase_location-global_position).length() < position_snap_range or chase_distance < 0:
			change_state("Idle")
			chase_distance = 0
	elif current_state().name == "Scared":
		if chase_distance < 0 and is_on_floor():
			change_state("Idle")
			chase_distance = 0
	# Sends movement data to the animation tree
	#animation_tree.set("parameters/Move/blend_position", blend_position)
	move_and_slide()
	chase_distance -= speed*delta

func deal_damage(target):
	if atk_target != null:
		if target.has_method("take_damage"):
			attack_sound.play()
			print("Frog: frog deals " + str(attack_damage) + " to player")
			target.take_damage(attack_damage)	


func death():
	velocity.x = 0
	velocity.y = 0
	death_sound.play()
	collision_shape.set_deferred("disabled", true)
	current_state().next_state = character_state_machine.states["Death"]

func change_state(state:String):
		current_state().next_state = character_state_machine.states[state]

func scare(body: CharacterBody2D, dist: int = 50):
	var scare_movement = global_position + (dist*(global_position - body.global_position).normalized())
	chase_location.x = scare_movement.x
	chase_location.y = global_position.y
	chase_distance = dist
	change_state("Scared")
	Game.scare_used = true

func _on_player_detection_body_entered(body):
	if body.name == "Player": 
		chase_location = Game.player_global_position
		chase_distance = (chase_location - global_position).x
		change_state("MoveToPoint")

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase_location = Game.player_global_position


func _on_player_collision_body_entered(body):
	if body.name == "Player" and character_state_machine.current_state.can_attack:
		atk_target = body
		change_state("Attack")

func _on_player_collision_body_exited(body):
	if body.name == "Player":
		atk_target = null


func _on_frog_hurtbox_body_entered(body):
	
	if body is TileMapLayer:
		var tile_coords = body.local_to_map(global_position)
		tile_coords.y += 1
		var tile_data = body.get_cell_tile_data(tile_coords)
		if tile_data:
			if tile_data.get_custom_data("is_spike"):
				take_damage(velocity.y)
	if current_state().name == "Scared":
		var fall_damage = velocity.y/30
		take_damage(fall_damage)
		if body.has_method("take_damage"):
			body.take_damage(fall_damage)
