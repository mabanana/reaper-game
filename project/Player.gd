extends CharacterBody2D
class_name PlayerBody

const scare_offset: int = 20
var scare_ability = load("res://scare_ability.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var jump_counter: int = 1
var player_alive: bool = true
var jump_direction: int = 0
var direction_pressed: int = 0
var is_jump: bool = false
var mob_jump: bool = false
var jump_damage: int = 1
var bump: bool = false
var jump_damage_to_mob: int
var name_animation_finished: String = ""
var direction: int
var idle: bool
var is_fast_fall: bool
var is_float: bool
var flight_direction : Vector2
var id: String = "Player"
var facing: int = 1
var blend_position: Vector2 = Vector2(0,0)
var camera_zoom = Vector2(2,2)

@export var player_camera: Camera2D
@export var anim: AnimationPlayer
@export var sprite_2d: Sprite2D
@export var death_sound: AudioStreamPlayer
@export var mob_jump_sound: AudioStreamPlayer
@export var walk_sound: AudioStreamPlayer
@export var jump_sound: AudioStreamPlayer
@export var hurt_sound: AudioStreamPlayer
@export var scare_sound: AudioStreamPlayer
@export var jump_velocity: int = -400
@export var speed = 300.0
@export var hit_stun_length = 0.1
@export var flight_time = 0.3
@export var flight_speed = 1000
@export var ground_state_machine: CharacterStateMachine
@export var action_state_machine: CharacterStateMachine


func _ready():
	print("Player: " + str(InputMap.action_get_events("scare")[0].as_text()))
	anim.animation_finished.connect(_on_player_animation_tree_animation_finished)
	anim.animation_started.connect(_on_player_animation_tree_animation_started)
	anim.play("Idle")
	
func _process(delta):
	if Game.dialogue_animation_playing:
		player_camera.global_position = Game.play_animation_body.global_position
		player_camera.zoom = Vector2(3,3)
	else:
		player_camera.position = Vector2.ZERO
		player_camera.zoom = camera_zoom
	
func _physics_process(delta):
	# Gets movement inputs
	if action_state_machine.is_can_move():
		direction = Input.get_axis("move_left", "move_right")
		check_facing(direction)
	# Sends paramenter data to Game state machine and character state machine
	Game.player_global_position = global_position
	action_state_machine.state_machine_process(delta)
	ground_state_machine.state_machine_process(delta)

	if action_state_machine.current_state.name == "Float":
		is_float = Input.is_action_pressed("float")
		if Input.is_action_just_pressed("float") and Game.unlocked_float:
			is_float = false
		elif (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("float")) and jump_counter > 0:
			is_float = false
		elif Input.is_action_just_pressed("left_click") and Game.unlocked_fly:
			#Does not work as intended when using touch screen
			#Take mouse position from event instead of global position
			is_float = false
			var mouse_pos = get_global_mouse_position()
			flight_direction = (mouse_pos - global_position).normalized()
			velocity = flight_direction * flight_speed
			action_state_machine.current_state.next_state = action_state_machine.states["Fly"]
	
	if action_state_machine.current_state.name == "Fly":
		velocity.x = move_toward(velocity.x, speed * flight_direction.x, speed/10)
		velocity.y = move_toward(velocity.y, speed * flight_direction.y, speed/10)


	if action_state_machine.current_state.can_attack:
		if Input.is_action_just_pressed("scare") and Game.unlocked_scare:
			print("Player: Scare action button pressed")
			action_state_machine.current_state.next_state = action_state_machine.states["Scare"]
			scare_attack()

	if action_state_machine.is_can_move():
		blend_position.x = direction

		if ground_state_machine.current_state.name == "Air":
			if Input.is_action_just_pressed("float") and Game.unlocked_float:
				is_float = true
				action_state_machine.current_state.next_state = action_state_machine.states["Float"]
			if Input.is_action_just_pressed("fast_fall"):
				is_fast_fall = true
	
		if jump_counter > 0 or ground_state_machine.current_state.name == "Ground":
			if Input.is_action_just_pressed("float") and !Game.unlocked_float:
					jump()
			elif Input.is_action_just_pressed("jump"):
					jump()
	
		if direction != 0:
			if jump_direction != direction:
				jump_direction = 0
			velocity.x = direction * speed
		# Changes deceleration depending on whether the player is in the air
		else:
			if ground_state_machine.current_state.name == "Ground":
				velocity.x = move_toward(velocity.x, 0, speed/3)
			elif ground_state_machine.current_state.name == "Air":
				if jump_direction != 0:
					velocity.x = move_toward(velocity.x, 0, speed/60)
				else:
					velocity.x = move_toward(velocity.x, 0, speed/3)


	if ground_state_machine.current_state.name == "Air":
		blend_position.x = 0
		if action_state_machine.has_gravity():
			if is_fast_fall:
				velocity.y += Game.gravity * delta * 5
			else:
				velocity.y += Game.gravity * delta
		#TODO: What is this for below.
#		if velocity.y == 0:
#			velocity.y += 1
	elif ground_state_machine.current_state.name == "Ground" and ground_state_machine.current_state.next_state == null:
		blend_position.y = 0
		jump_reset()
		is_fast_fall = false
		is_float = false


	blend_position.y = -velocity.y
	blend_position = blend_position.normalized()
	jump_damage_to_mob = jump_damage + int(jump_damage + velocity.y / 100)
	move_and_slide()



	# Sends player into death state if health drops below 0
	if Game.player_hp <= 0 and action_state_machine.current_state.name != "Death":
		action_state_machine.current_state.next_state = action_state_machine.states["Death"]

func jump():
	jump_sound.play()
	velocity.y = jump_velocity
	ground_state_machine.current_state.next_state = ground_state_machine.states["Air"]
	jump_direction = direction
	if ground_state_machine.current_state.name == "Air":
		jump_counter -= 1

func scare_attack():
	scare_sound.play()
	var scare_hitbox : Area2D = scare_ability.instantiate()
#	scare_hitbox.global_position = global_position
	scare_hitbox.position.x = scare_offset * facing
	add_child(scare_hitbox)

func jump_reset():
	if Game.jump_has_dbl:
		jump_counter = 1
	else:
		jump_counter = 0

func take_damage(dmg: int = 1):
	if dmg > 0:
		Game.player_hp -= dmg
		if action_state_machine.current_state.name != "Death":
			action_state_machine.current_state.next_state = action_state_machine.states["Hurt"]

func check_facing(input_dir: int = 0):
	var dir: int
	if input_dir != 0:
		dir = input_dir
	else: 
		dir = velocity.x
	if dir < 0:
		sprite_2d.flip_h = true
		facing = -1
	elif dir > 0:
		sprite_2d.flip_h = false
		facing = 1


func _on_mob_jump_collision_body_entered(body):
	print("Player: " + "landed on an body: " + str(body.name))
	if body.get_parent().name == "Mobs" and body.health > 0:
		if ground_state_machine.current_state.name == "Air":	
			jump_counter += 1
			is_fast_fall = false
			jump()
			if body.has_method("take_damage") and Game.jump_has_dmg:
				print("Player: " + "player dealt " + str(jump_damage_to_mob) + " to a " + str(body.name))
				body.take_damage(jump_damage_to_mob)
				mob_jump_sound.play()
				Game.start_camera_shake(0.2)


	if body is TileMapLayer:
		var tile_coords = body.local_to_map(global_position)
		tile_coords.y += 1
		var tile_data = body.get_cell_tile_data(tile_coords)
		if tile_data:
			if tile_data.get_custom_data("is_spike"):
				take_damage()


func _on_mob_jump_collision_area_entered(area):
	print("Player: " + "landed on an area: " + str(area.name))
	pass


func _on_player_animation_tree_animation_finished(anim_name):
	name_animation_finished = anim_name
func _on_player_animation_tree_animation_started(anim_name):
	name_animation_finished = ""


func _on_hurtbox_body_entered(body):
	print("Player: a " + str(body.name) + " has collided with the player's hitbox")
	

func die():
	get_tree().change_scene_to_file("res://Scenes/end_scene.tscn")
