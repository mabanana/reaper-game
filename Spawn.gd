extends State

class_name SpawnState
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var idle_state: State
@export var spawn_sound: AudioStreamPlayer2D
var is_spawned = false

func state_process(delta):
	if is_spawned:
		next_state = idle_state

func on_enter():
	anim.play("Idle")
	anim.stop()
	character.modulate.a = 0.3
	var tween = get_tree().create_tween()
	tween.tween_property(character, "modulate:a", 1, 0.5)
	await tween.finished
	is_spawned = true

func on_exit():
	pass
