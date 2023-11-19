extends CharacterBody2D

var jump_counter = 1
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
	jump_counter = 0

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
		is_running_jump = false
		jump_counter = 1
		
	# Handle Jump.
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_pressed("ui_accept")) and is_on_floor():
		player_jump(direction)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#if direction == -1:
	#	get_node("animdSprite2D").flip_h = true
	#if direction == 1:
	#	get_node("animdSprite2D").flip_h = false
	
	if direction != 0:
		$AnimatedSprite2D.flip_h = (direction == -1)
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
			velocity.x = move_toward(velocity.x, 0, SPEED/10)
		if velocity.y == 0:
			anim.play("Idle")
		
	move_and_slide()
	
	if Game.player_hp <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")


func _on_area_2d_body_entered(body):
	jump_counter = 1
