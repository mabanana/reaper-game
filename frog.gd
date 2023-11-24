extends Mob

@onready var has_gravity: bool = true
@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D
@export var character_state_machine: CharacterStateMachine

var name_animation_finished: String = ""

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	if character_state_machine.current_state.can_move:
		# Calculate the direction towards the player for chasing
		var direction = (Game.player_global_position - global_position).normalized()

		if direction.x >= 0.5:
			velocity.x = direction.x + speed
			sprite_2d.flip_h = true
		elif direction.x <= -0.5:
			velocity.x = direction.x - speed
			sprite_2d.flip_h = false
		#Adds gravity if not on the floor
		if not is_on_floor():
			velocity.y += gravity * delta

		# Sends movement data to the animation tree
		animation_tree.set("parameters/Move/blend_position", velocity)
		move_and_slide()




func _on_player_detection_body_entered(body):
	if body.name == "Player": 
		chase = true
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		can_atk = true
func _on_player_collision_body_exited(body):
	if body.name == "Player":
		can_atk = false


#func attack():
#	var direction = (player.global_position - global_position).normalized()
#	$frog_attack.play()
#	velocity.x += direction.x * -1200
#	velocity.y += direction.y * -100
##	move_and_collide(velocity)
#	move_and_slide()
#	Game.player_hp -= attack_damage
#	print("Frog: frog deals " + str(attack_damage) + " to player")


#func death():
#	has_gravity = false
#	chase = false
#	anim.play("Death")
#	$CollisionShape2D.set_deferred("disabled",true)	
#	await anim.animation_finished
#	print("Frog: frog dies")
#	#Utils.save()
#	self.queue_free()
	


func _on_frog_animation_tree_animation_finished(anim_name):
	name_animation_finished = anim_name

