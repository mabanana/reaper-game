extends State

class_name AttackState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var idle_state: State
@export var attack_animation: String = "Jump"
@export var attack_sound: AudioStreamPlayer2D
@export var attack_damage: int



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
