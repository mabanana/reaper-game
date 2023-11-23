extends State

class_name DeathState

func on_enter():
#	TODO: node references change to @export
	$"../../CollisionShape2D".set_deferred("disabled", true)
	$"../../Mob Collision/CollisionShape2D2".set_deferred("disabled", true)
	character.velocity.y = 0
	# Causes player to float up slightly on death
	var tween = get_tree().create_tween()
	tween.tween_property(character, "position", character.position - Vector2 (3 , 15), 3.4)
	$"../../SFX/player_death".play()
	playback.travel("Death")
	$Timer.start(3.4)


func _on_timer_timeout():
	queue_free()
	print("DeathState: change scene to game over scene")
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
