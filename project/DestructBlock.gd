extends StaticBody2D
@export var animated_sprite: AnimatedSprite2D
@export var trigger_body_name: String
@export var collision_shape: CollisionShape2D
@export var death_sound: AudioStreamPlayer
var triggered = false
func _ready():
	animated_sprite.play("Idle")
func _on_area_2d_body_entered(body):
	print("DestructBlock: "+ body.name +" entered")
	if body.name == trigger_body_name and not triggered:
		triggered = true
		collision_shape.set_deferred("disabled", true)
		animated_sprite.play("Death")
		death_sound.play(0.6)
		await animated_sprite.animation_finished
		queue_free()

