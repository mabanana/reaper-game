extends Node2D
@export var win_sound: AudioStreamPlayer
func _process(delta):
	if Game.gems_collected == 2 and get_node("Mobs").get_child_count() == 1:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		win_sound.play()
func _on_find_pet_body_entered(body):
	await DialogueManager.dialogue_ended
	Game.pet_acquired = true


func _on_frog_dungeon_body_entered(body):
	await DialogueManager.dialogue_ended
	for spawn_marker in find_child("Spawners").get_children():
		if spawn_marker.trigger == $Triggers/FrogDungeon:
			find_child("Mobs").spawn_frog(spawn_marker.global_position)
	
func on_dialogue_manager_dialogue_ended():
	pass


func _on_boss_reaper_room_body_entered(body):
	await DialogueManager.dialogue_ended
	Game.boss_reaper_room = true


func _on_boss_reaper_room_exit_body_entered(body):
	await DialogueManager.dialogue_ended
	Game.boss_reaper_room_exit = true


func _on_boss_reaper_room_exit_2_body_entered(body):
	pass


func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(100)
