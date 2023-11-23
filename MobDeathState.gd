extends State

class_name MobDeathState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var death_animation: String = "Death"
@export var death_sound: AudioStreamPlayer2D

func on_enter():
	death_sound.play()
	anim.play(death_animation)
	$"../../CollisionShape2D".set_deferred("disabled",true)	

func _process(delta):
	if anim.frame == 5:
		print("FrogDeathState: frog dies")
		character.queue_free()


func _on_timer_timeout():
	pass
