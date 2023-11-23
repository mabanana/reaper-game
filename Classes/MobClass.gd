extends CharacterBody2D
class_name Mob

var player
var chase = false
var is_spawned = false
var can_atk: bool = false
@export var health: int
@export var drop_amount: int
@export var drop_range: int
@export var attack_damage: int


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _physics_process(delta):
	pass




