extends CharacterBody2D

var jump_counter = 1
var player_alive = true
var is_running_jump = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")

func player_jump(direction):
	velocity.y = JUMP_VELOCITY
	if direction != 0:
		is_running_jump = true
	jump_counter -= 1

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	if player_alive == true:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
			if velocity.y > 0:
				anim.play("Fall")
			elif velocity.y < 0:
				anim.play("Jump")
		else:
			is_running_jump = false
			if Game.gem_collected == true:
				jump_counter = 2
			
			else:
				jump_counter = 1
			
		# Handle Jump.
		if Input.is_action_just_pressed("jump") and jump_counter > 0:
			player_jump(direction)
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		
		
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
		
		if Game.player_hp <= 0:
			player_alive = false
	elif player_alive == false and $AnimatedSprite2D.animation != "Death":
		player_death()

func _on_area_2d_body_entered(body):
	if body.get_parent().name == "Mobs":
		if Game.gem_collected == true:
			jump_counter = 1
			
		else:
			jump_counter = 0
		player_jump(0)

func player_death():
	velocity.y = SPEED
	#$Camera2D.enabled = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position - Vector2 (3 , 15), 0.3)
	anim.play("Death")
	await anim.animation_finished
	print("remove")
	queue_free()
	get_tree().change_scene_to_file("res://game_over.tscn")
