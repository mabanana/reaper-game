extends Mob

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var player: CharacterBody2D
#var chase: bool = false
#var is_spawned: bool = false
#var health: int = 1
#var drop_amount: int = 2
#var drop_range: int = 1
#var attack_damage: int = 1
@onready var has_gravity: bool = true
@onready var anim: AnimatedSprite2D = get_node("AnimatedSprite2D")


func _ready():
	self.modulate.a = 0.3
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.5)
	await tween.finished
	anim.play("Idle")
	is_spawned = true
	


func _physics_process(delta):
	# Add the gravity.
	if is_spawned:
		
		if can_atk:
			attack()
			
			
		if has_gravity == true and not is_on_floor():
			velocity.y += gravity * delta * 0.8
		else:
			velocity.y = 0
			velocity.x = 0
		player = get_node("../../Player/Player")
		var direction = (player.global_position - global_position).normalized()
		

		if chase and is_spawned:	
			if direction.x >= 0.5:
				velocity.x = direction.x + SPEED
				anim.play("Jump")
				anim.flip_h = true
			elif direction.x <= -0.5:
				velocity.x = direction.x - SPEED
				anim.play("Jump")
				anim.flip_h = false		
		else:
			if anim.animation != "Death":
				anim.play("Idle")
				velocity.x = 0
				
		move_and_slide()
	if health <= 0  and anim.animation != "Death":
		$"Hurtbox".set_monitorable(false)
		$frog_death.play()
		death()
	
	
func _on_player_detection_body_entered(body):
	if body.name == "Player" and anim.animation != "Death": 
		chase = true
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_collision_body_entered(body):
	if body.name == "Player" and anim.animation != "Death" and is_spawned == true:
		can_atk = true

func _on_player_collision_body_exited(body):
	if body.name == "Player" and anim.animation != "Death" and is_spawned == true:
		can_atk = false

func attack():
	var direction = (player.global_position - global_position).normalized()
	$frog_attack.play()
	velocity.x += direction.x * -1200
	velocity.y += direction.y * -100
#	move_and_collide(velocity)
	move_and_slide()
	Game.player_hp -= attack_damage
	print("Frog: frog deals " + str(attack_damage) + " to player")

func death():
	has_gravity = false
	chase = false
	anim.play("Death")
	$CollisionShape2D.set_deferred("disabled",true)	
	await anim.animation_finished
	print("Frog: frog dies")
	#Utils.save()
	self.queue_free()
	
	



