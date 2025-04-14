extends Mob
@export var cast_sound: AudioStreamPlayer2D
@export var cast_sound_2: AudioStreamPlayer2D
signal interacted
func _ready():
	pass
func _physics_process(delta):
	# Add the gravity.
	if current_state().has_gravity and !is_on_floor():
		velocity.y += gravity * delta
	character_state_machine.state_machine_process(delta)
	#animation_tree.set("parameters/Move/blend_position", velocity.x)
	
	move_and_slide()

func interact():
	interacted.emit()
