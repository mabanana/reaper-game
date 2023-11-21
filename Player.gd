extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
var jump_counter = 1
var player_alive = true
var is_running_jump = false



func _physics_process(delta):
	
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
			
		# Handle jump inputs
		if Input.is_action_just_pressed("jump") and jump_counter != 0:
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
		move_and_slide()
		# Sets player state to dead when HP falls below 0
		if Game.player_hp <= 0:
			player_alive = false
	elif player_alive == false and $AnimatedSprite2D.animation != "Death":
		player_death()

func _on_area_2d_body_entered(body):
	if body.get_parent().name == "Mobs" and velocity.y > 0 and player_alive:
		body.health -= 1
		$SFX/player_land_on_mob.play()
		player_jump(0)
		if Game.gem_collected == true:
			jump_counter = 1		
		else:
			jump_counter = 0
	elif $SFX/player_land_on_ground.playing == false:
		$SFX/player_land_on_ground.play()

		
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
	if direction != 0:
		is_running_jump = true
	jump_counter -= 1
#	if jump_counter > 0:
#		jump_counter -= 1
