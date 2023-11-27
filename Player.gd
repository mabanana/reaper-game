extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var jump_counter: int = 1
var player_alive: bool = true
var jump_direction: int = 0
var direction_pressed: int = 0
var is_jump: bool = false
var mob_jump: bool = false
var jump_damage: int = 1
var bump: bool = false
var dmg: int
var name_animation_finished: String = ""
var direction: int
var idle: bool
@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D
@export var death_sound: AudioStreamPlayer
@export var mob_jump_sound: AudioStreamPlayer
@export var walk_sound: AudioStreamPlayer
@export var jump_sound: AudioStreamPlayer
@export var hurt_sound: AudioStreamPlayer
@export var jump_velocity: int = -400
@export var speed = 300.0
@export var hit_stun_length = 0.1
@export var ground_state_machine: CharacterStateMachine
@export var action_state_machine: CharacterStateMachine




func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Gets movement inputs
	direction = Input.get_axis("move_left", "move_right")
	var blend_position: Vector2
	if jump_counter > 0:
		if Input.is_action_just_pressed("jump"):
				jump()
		elif Input.is_action_pressed("jump") and is_on_floor():
				jump()


	# Sends paramenter data to Game state machine and character state machine
	Game.player_global_position = global_position
	action_state_machine.state_machine_process(delta)
	ground_state_machine.state_machine_process(delta)


	if ground_state_machine.is_can_move() and action_state_machine.is_can_move():
		if direction != 0:
			if direction == -1:
				sprite_2d.flip_h = true
			elif direction == 1:
				sprite_2d.flip_h = false
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
		blend_position.x = direction
		
	if ground_state_machine.current_state.name == "Air":
		blend_position.x = 0
		if ground_state_machine.current_state.has_gravity and action_state_machine.current_state.has_gravity:
			velocity.y += Game.gravity * delta
		if velocity.y == 0:
			velocity.y += 1
	elif ground_state_machine.current_state.name == "Ground":
		blend_position.y = 0
		jump_reset()
		
	blend_position.y = -velocity.y
	blend_position = blend_position.normalized()
	# Sends parameter data to the animation tree
	animation_tree.set("parameters/Move/blend_position", blend_position)
	dmg = jump_damage + int(jump_damage + velocity.y / 100)
	move_and_slide()



	# Sends player into death state if health drops below 0
	if Game.player_hp <= 0 and action_state_machine.current_state.name != "Death":
		action_state_machine.current_state.next_state = action_state_machine.states["Death"]

func jump():
	jump_sound.play()
	velocity.y = jump_velocity
	ground_state_machine.current_state.next_state = ground_state_machine.states["Air"]
	jump_direction = direction
	jump_counter -= 1

func jump_reset():
	if Game.gems_collected > 1:
		jump_counter = 2
	else:
		jump_counter = 1

func take_damage(dmg: int = 1):
	Game.player_hp -= dmg
	if action_state_machine.current_state.name != "Death":
		action_state_machine.current_state.next_state = action_state_machine.states["Hurt"]


func _on_mob_jump_collision_body_entered(body):
	print("Player: " + "landed on an body: " + str(body.name))
	if body.get_parent().name == "Mobs" and body.health > 0:
		if ground_state_machine.current_state.name == "Air":	
			body.health -= dmg
			print("Player: " + "player dealt " + str(dmg) + " to a " + str(body.name))
			jump_counter += 1
			jump()
			mob_jump_sound.play()
				
	if body.name == "TileMap":
		var tile_coords = body.local_to_map(global_position)
		tile_coords.y += 1
		var tile_data = body.get_cell_tile_data(0 , tile_coords)
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
	if body.has_method("deal_damage"):
		take_damage(body.deal_damage())


func _on_animation_tree_animation_finished(anim_name):
	name_animation_finished = anim_name


func _on_animation_tree_animation_started(anim_name):
	name_animation_finished = ""
