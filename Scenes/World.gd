extends Node2D


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
