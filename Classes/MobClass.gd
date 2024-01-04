extends CharacterBody2D
class_name Mob

var chase = false
var can_atk: bool = false
@export var collision_shape: CollisionShape2D
@export var health: int
@export var drop_amount: int
@export var drop_range: int
@export var attack_damage: int
@export var speed: int
@export var jump_velocity: int
@export var id: String

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


func death():
	pass

