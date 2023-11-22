extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
var jump_counter: int = 1
var player_alive: bool = true
var is_running_jump: bool = false
var is_jump: bool = false
var mob_jump: bool = false
var jump_damage: int = 1



func _physics_process(delta):
	# check if is_on_floor was true last physics frame
	var was_on_floor = is_on_floor()
	move_and_slide()


	# Gets movement inputs
	var direction = Input.get_axis("move_left", "move_right")
	if player_alive == true:
		# Adds the gravity and plays air animations.
		# Resets jump counters for when the player is on the ground
		if not is_on_floor():
			velocity.y += gravity * delta
			if velocity.y > 0:
				anim.play("Fall")
			elif velocity.y < 0:
				anim.play("Jump")
		else:
			is_jump = false
			is_running_jump = false
			if Game.gem_collected == true:
				jump_counter = 2
			else:
				jump_counter = 1




		# Get the input direction and handle the movement/deceleration.
		if direction != 0:
			if direction == -1:
				$AnimatedSprite2D.flip_h = true
			elif direction == 1:
				$AnimatedSprite2D.flip_h = false
			if velocity.x * direction < 0:
				is_running_jump = false
			velocity.x = direction * SPEED
			if velocity.y == 0:
				anim.play("Run")




		# Changes deceleration depending on whether the player is in the air
		else:
			if is_on_floor():
				velocity.x = move_toward(velocity.x, 0, SPEED/3)
			elif is_running_jump:
				velocity.x = move_toward(velocity.x, 0, SPEED/60)
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED/3)
			if velocity.y == 0:
				anim.play("Idle") 



		# Handles jumps on mobs, otherwise checks for jump inputs
		if mob_jump == true:
			mob_jump = false
			$SFX/player_land_on_mob.play()
			player_jump(0)
			if Game.gem_collected == true:
				jump_counter = 1		
			else:
				jump_counter = 0
			# Handle jump inputs
		elif Input.is_action_just_pressed("jump") and jump_counter != 0:
			$SFX/player_jump.play()
			player_jump(direction)
			# Allows for press and hold jumping without triggering instant double jumps
		elif Input.is_action_pressed("jump") and is_on_floor():
			$SFX/player_jump.play()
			player_jump(direction)	



		# Check for if player is not is_on_floor without jumping:	
		if was_on_floor == true and not is_on_floor():
			if is_jump and jump_counter > 0 :
				jump_counter -= 1
			elif not is_jump and velocity.y > 0:
				was_on_floor = false
				jump_counter -= 1
				print("Player: player walked off a floor object with " + str(jump_counter) + " jump counters left")	



		# Sets player state to dead when HP falls below 0
		if Game.player_hp <= 0:
			player_alive = false

	# Calls player death function
	elif player_alive == false and $AnimatedSprite2D.animation != "Death":
		player_death()


func _on_area_2d_body_entered(body):
	print("Player: " + "player landed on a body " + str(body.name))
	print("Player: Parent: " + str(body.get_parent().name) + ", falling: " + str(velocity.y >= 0) + ", is_alive: " + str(player_alive) )
	if body.get_parent().name == "Mobs" and velocity.y >= 0 and player_alive:
		mob_jump = true
		body.health -= 1
		print("Player: " + "dealt " + str(jump_damage) + " to a " + str(body.name))
		#$SFX/player_land_on_mob.play()
		#player_jump(0)
#		if Game.gem_collected == true:
#			jump_counter = 1		
#		else:
#			jump_counter = 0
	if $SFX/player_land_on_ground.playing == false:
		$SFX/player_land_on_ground.play()

func _on_mob_collision_area_entered(area):
	print("Player: " + "landed on an area: " + str(area.name))
#	if area.name == "Hurtbox" and velocity.y >= 0 and player_alive:
#		mob_jump = true
#		area.get_parent().health -= jump_damage
#		print("Player: " + "dealt " + str(jump_damage) + " to a " + str(area.get_parent().name))


func player_death():
	$CollisionShape2D.set_deferred("disabled", true)
	velocity.y = 0
	# Causes player to float up slightly on death
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position - Vector2 (3 , 15), 0.3)
	anim.play("Death")
	await anim.animation_finished
	queue_free()
	print("Player: change scene to game over scene")
	get_tree().change_scene_to_file("res://game_over.tscn")
	
	
func player_jump(direction):
	is_jump = true
	velocity.y = JUMP_VELOCITY
	print("Player: player jumps")
	if direction != 0:
		is_running_jump = true
	print("Player: " + str(jump_counter) + " jump counters left")
