extends Mob
var name_animation_finished: String

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if current_state().has_gravity and !is_on_floor():
		velocity.y += gravity * delta
	character_state_machine.state_machine_process(delta)
	animation_tree.set("parameters/Move/blend_position", velocity.x)
	
	move_and_slide()


func _on_animation_tree_animation_started(anim_name):
	name_animation_finished = ""


func _on_animation_tree_animation_finished(anim_name):
	name_animation_finished = anim_name
