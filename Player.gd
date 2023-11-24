extends CharacterBody2D

const speed = 300.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
var jump_counter: int = 1
var player_alive: bool = true
var jump_direction: int = 0
var direction_pressed: int = 0
var is_jump: bool = false
var mob_jump: bool = false
var jump_damage: int = 1
var bump: bool = false
@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D
@export var character_state_machine: CharacterStateMachine

var name_animation_finished: String = ""


func _ready():
	animation_tree.active = true

func _physics_process(delta):
	
	# Gets movement inputs
	var direction = Input.get_axis("move_left", "move_right")
	direction_pressed = direction
	# Sends parameter data to the animation tree
	animation_tree.set("parameters/Move/blend_position", direction)
	# Sends paramenter data to Game state machine and character state machine
	Game.player_global_position = global_position
	character_state_machine.state_machine_process(delta)
	
	if character_state_machine.is_can_move():
		if direction != 0:
			if direction == -1:
				sprite_2d.flip_h = true
			elif direction == 1:
				sprite_2d.flip_h = false
			if velocity.x * direction < 0:
				jump_direction = 0
			velocity.x = direction * speed
		# Changes deceleration depending on whether the player is in the air
		else:
			if character_state_machine.current_state.name == "Ground":
				velocity.x = move_toward(velocity.x, 0, speed/3)
			elif character_state_machine.current_state.name == "Air":
				if jump_direction != 0:
					velocity.x = move_toward(velocity.x, 0, speed/60)
				else:
					velocity.x = move_toward(velocity.x, 0, speed/3)
	else:
		velocity.x = 0
		
	if not is_on_floor() and character_state_machine.current_state.has_gravity == true:
		velocity.y += gravity * delta
	
	move_and_slide()
	# Sends player into death state if health drops below 0
	if Game.player_hp <= 0 and character_state_machine.current_state.name != "Death":
		character_state_machine.current_state.next_state = character_state_machine.current_state.death_state


func _on_mob_bump_collision_body_entered(body):
	if character_state_machine.current_state.name == "Ground":
		print("Player: " + "bumped into a body: " + str(body.name))
		if body.get_parent().name == "Mobs" and body.health > 0:
			bump = true

func _on_mob_bump_collision_body_exited(body):
	bump = false
		

func _on_mob_jump_collision_body_entered(body):
	if character_state_machine.current_state.name == "Air":
		print("Player: " + "landed on an body: " + str(body.name))
		if body.get_parent().name == "Mobs" and body.health > 0:
			var dmg = jump_damage + int(jump_damage + velocity.y / 100)
			body.health -= dmg
			print("Player: " + "player dealt " + str(jump_damage) + " to a " + str(body.name))
			mob_jump = true

func _on_mob_jump_collision_area_entered(area):
	print("Player: " + "landed on an area: " + str(area.name))
	pass


func _on_player_animation_tree_animation_finished(anim_name):
	name_animation_finished = anim_name


func _on_player_animation_tree_animation_started(anim_name):
	name_animation_finished = ""



