extends RigidBody2D
@export var animated_sprite: AnimatedSprite2D
@export var trigger_body_name: String
@export var collision_shape: CollisionShape2D

func _ready():
	animated_sprite.play("Idle")
func _on_area_2d_body_entered(body):
	print("DestructBlock: "+ body.name +" entered")
	if body.name == trigger_body_name:
		collision_shape.set_deferred("disabled", true)
		animated_sprite.play("Death")
		await animated_sprite.animation_finished
		queue_free()
