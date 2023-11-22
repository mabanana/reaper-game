extends CharacterBody2D
class_name Mob

var player
var chase = false
var is_spawned = false
@export var health: int
@export var drop_amount: int
@export var drop_range: int
@export var attack_damage: int


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	self.modulate.a = 0.3
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.5)
	await tween.finished
	is_spawned = true
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	

	move_and_slide()
