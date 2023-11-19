extends CharacterBody2D

var PlayerSpeed = 0
var RunningJump = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")


func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			anim.play("Fall")
		elif velocity.y < 0:
			anim.play("Jump")
	else:


		RunningJump = false
		
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if direction != 0:
			RunningJump = true

	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#if direction == -1:
	#	get_node("animdSprite2D").flip_h = true
	#if direction == 1:
	#	get_node("animdSprite2D").flip_h = false
	
	if direction != 0:
		$AnimatedSprite2D.flip_h = (direction == -1)
		if velocity.x * direction < 0:
			RunningJump = false
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, SPEED/3)
		elif RunningJump:
			velocity.x = move_toward(velocity.x, 0, SPEED/60)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED/10)
		if velocity.y == 0:
			anim.play("Idle")
		
	move_and_slide()
	
	if Game.player_hp <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
