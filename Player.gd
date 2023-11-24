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
	if player_alive == true:
		# Adds the gravity and plays air animations.
		# Resets jump counters for when the player is on the ground
		animation_tree.set("parameters/Move/blend_position", direction)
		# Get the input direction and handle the movement/deceleration.
		if direction != 0 and character_state_machine.is_can_move():
			
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

		move_and_slide()
		Game.player_global_position = global_position

		# Sets player state to dead when HP falls below 0
		if Game.player_hp <= 0:
			player_alive = false

	# Calls player death function
	elif player_alive == false and character_state_machine.current_state.name != "Death":
		character_state_machine.current_state.next_state = character_state_machine.current_state.death_state


func _on_area_2d_body_entered(body):
	if $SFX/player_land_on_ground.playing == false:
		$SFX/player_land_on_ground.play()

func _on_mob_collision_area_entered(area):
	print("Player: " + "landed on an area: " + str(area.name))
	pass

func player_death():
	$CollisionShape2D.set_deferred("disabled", true)
	velocity.y = 0
	# Causes player to float up slightly on death
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position - Vector2 (3 , 15), 0.3)
	$SFX/player_death.play()
	anim.play("Death")
	await anim.animation_finished
	queue_free()
	print("Player: change scene to game over scene")
	get_tree().change_scene_to_file("res://game_over.tscn")



func _on_player_animation_tree_animation_finished(anim_name):
	name_animation_finished = anim_name
