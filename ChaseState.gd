extends State

class_name ChaseState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var idle_state: State
@export var attack_state: State
@export var speed : int = 300
@export var run_animation: String = "Jump"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
