extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
@onready var has_gravity = true
@onready var anim = get_node("AnimatedSprite2D")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready():
	anim.play("Idle")


func _physics_process(delta):
	# Add the gravity.
	if has_gravity == true:
		velocity.y += gravity * delta * 0.8
	else:
		velocity.y = 0
		velocity.x = 0
	player = get_node("../../Player/Player")
	var direction = (player.global_position - global_position).normalized()
	

	if chase:	
		if direction.x >= 0.5:
			velocity.x = direction.x + SPEED / 2
			anim.play("Jump")
			anim.flip_h = true
		elif direction.x <= -0.5:
			velocity.x = direction.x - SPEED / 2
			anim.play("Jump")
			anim.flip_h = false		
	else:
		if anim.animation != "Death":
			anim.play("Idle")
			velocity.x = 0
			
	move_and_slide()
	
	
func _on_player_detection_body_entered(body):

	if body.name == "Player" and anim.animation != "Death": 
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_hurt_box_body_entered(body):
	if body.name == "Player" and anim.animation != "Death":
		death()
		Game.player_gold += 5
		


func _on_player_collision_body_entered(body):
	if body.name == "Player" and anim.animation != "Death":
		death()
		Game.player_hp -= 2
		
func death():
	has_gravity = false
	chase = false
	$"Hurt Box".set_monitoring(true)
	anim.play("Death")
	$CollisionShape2D.set_deferred("disabled",true)	
	await anim.animation_finished
	#Utils.saveGame()
	self.queue_free()
	
