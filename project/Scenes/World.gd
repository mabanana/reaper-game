extends Node2D
@export var win_sound: AudioStreamPlayer
@export var bgm: AudioStreamPlayer

var dialogue_controller: DialogueController

func _ready():
	bgm.play()
	dialogue_controller = load("res://Dialogue/Controller/dialogue_controller.tscn").instantiate()
	$UI.add_child(dialogue_controller)
	dialogue_controller.hide()
	%ControlsButton.pressed.connect(func ():
		%ControlsList.show()
		)
	

func _process(delta):
	pass

func _on_find_pet_body_entered(body):
	if (body is PlayerBody 
	and body.action_state_machine.current_state.name != "Busy" 
	and not Game.pet_acquired):
		body.action_state_machine.current_state.next_state = body.action_state_machine.states["Busy"]
		dialogue_controller.start("res://Dialogue/Json/PetFound.json")
		
		await dialogue_controller.dialogue_ended
		
		body.action_state_machine.current_state.next_state = body.action_state_machine.states["Idle"]
		print("pet_acquired dialogue ended".capitalize())

func _on_frog_dungeon_body_entered(body):
	#TODO: Add spawn frog trigger logic
	for spawn_marker in find_child("Spawners").get_children():
		if spawn_marker.trigger == $Triggers/FrogDungeon:
			find_child("Mobs").spawn_frog(spawn_marker.global_position)
	
func on_dialogue_manager_dialogue_ended():
	pass


func _on_boss_reaper_room_body_entered(body):
	if (body is PlayerBody 
	and body.action_state_machine.current_state.name != "Busy" 
	and not Game.boss_reaper_room):
		body.action_state_machine.current_state.next_state = body.action_state_machine.states["Busy"]
		dialogue_controller.start("res://Dialogue/Json/BossReaperRoom1.json")
		
		await dialogue_controller.dialogue_ended
		
		body.action_state_machine.current_state.next_state = body.action_state_machine.states["Idle"]
		%StaticBody2D.queue_free()
		print("boss_reaper_room dialogue ended".capitalize())
		


func _on_boss_reaper_room_exit_body_entered(body):
	if (body is PlayerBody 
	and body.action_state_machine.current_state.name != "Busy" 
	and not Game.boss_reaper_room_exit):
		if Game.boss_reaper_room:
			body.action_state_machine.current_state.next_state = body.action_state_machine.states["Busy"]
			dialogue_controller.start("res://Dialogue/Json/BossReaperRoomExit.json")
			
			await dialogue_controller.dialogue_ended
			
			body.action_state_machine.current_state.next_state = body.action_state_machine.states["Idle"]
			print("boss_reaper_room_exit dialogue ended".capitalize())
			Game.boss_reaper_room_exit = true
			Game.unlocked_scare = true
		else:
			body.action_state_machine.current_state.next_state = body.action_state_machine.states["Busy"]
			dialogue_controller.start("res://Dialogue/Json/BossReaperRoomExit2.json")
			
			await dialogue_controller.dialogue_ended
			
			body.action_state_machine.current_state.next_state = body.action_state_machine.states["Idle"]
			print("boss_reaper_room_exit_2 dialogue ended".capitalize())


func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(100)


func _on_audio_stream_player_2_finished():
	bgm.play()
