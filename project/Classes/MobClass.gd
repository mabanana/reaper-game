extends CharacterBody2D
class_name Mob


var chase = false
var can_atk: bool = false
var name_animation_finished: String
@export var collision_shape: CollisionShape2D
@export var health: int
@export var drop_amount: int
@export var drop_range: int
@export var attack_damage: int
@export var speed: int
@export var jump_velocity: int
@export var id: String
@export var anim: AnimationPlayer
@export var sprite_2d: Sprite2D
@export var character_state_machine: CharacterStateMachine

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	pass

func _physics_process(delta):
	pass

func take_damage(dmg: int = 1):
	if dmg > 0:
		health -= dmg
	if health <= 0:
		death()

func change_state(nextstate: String):
	current_state().next_state = character_state_machine.states[nextstate]

func current_state():
	return character_state_machine.current_state


func death():
	collision_shape.set_deferred("disabled", true)
	current_state().next_state = character_state_machine.states["Death"]


func _on_animation_tree_animation_started(anim_name):
	name_animation_finished = ""


func _on_animation_tree_animation_finished(anim_name):
	name_animation_finished = anim_name
