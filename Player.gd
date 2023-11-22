extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
var jump_counter: int = 1
var player_alive: bool = true
var is_running_jump: bool = false
var mob_jump: bool = false
var jump_damage: int = 1



func _physics_process(delta):
	move_and_slide()
	var direction = Input.get_axis("move_left", "move_right")
	if player_alive == true:
		# Adds the gravity and plays air animations.
		if not is_on_floor():
			velocity.y += gravity * delta
			if velocity.y > 0:
				anim.play("Fall")
			elif velocity.y < 0:
				anim.play("Jump")
				
		# Resets jump counters for when the player is on the ground
		else:
			is_running_jump = false
			if Game.gem_collected == true:
				jump_counter = 2
			else:
				jump_counter = 1
			
		#handles jumps on mobs
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
		elif Input.is_action_pressed("jump") and is_on_floor():
			$SFX/player_jump.play()
			player_jump(direction)
		
			

		# Get the input direction and handle the movement/deceleration.
		if direction != 0:
			if direction == -1:
				$AnimatedSprite2D.flip_h = true
			if direction == 1:
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
					
		
		# Sets player state to dead when HP falls below 0
		if Game.player_hp <= 0:
			player_alive = false
	elif player_alive == false and $AnimatedSprite2D.animation != "Death":
		player_death()

func _on_area_2d_body_entered(body):
	print("Player: " + "player landed on a body " + str(body.name))
	print("Player: Parent: " + str(body.get_parent().name) + ", player y-velo: " + str(velocity.y) + ", is_alive: " + str(player_alive) )
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
	velocity.y = SPEED
	#$Camera2D.enabled = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position - Vector2 (3 , 15), 0.3)
	anim.play("Death")
	await anim.animation_finished
	queue_free()
	get_tree().change_scene_to_file("res://game_over.tscn")
	
	
func player_jump(direction):
	velocity.y = JUMP_VELOCITY
	print("Player: player jumps")
	if direction != 0:
		is_running_jump = true
	if jump_counter > 0:
		jump_counter -= 1
	print("Player: " + str(jump_counter) + " jump counters left")
