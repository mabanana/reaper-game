extends Node

var player_hp: int = 10
var player_gold: int = 0
var player_alive: bool = true
var jump_has_dmg: bool = false
var jump_has_dbl: bool = false
var unlocked_scare: bool = false
var unlocked_float: bool = false
var unlocked_fly: bool = false
var scare_used: bool = false
var pet_acquired: bool = false
var boss_reaper_room: bool = false
var boss_reaper_room_exit: bool = false

var gems_collected: int = 0
var player_global_position: Vector2
var show_player_msg: bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var play_animation_body: CharacterBody2D
var dialogue_animation_playing: bool = false


func set_animation_body(body_path: String = "/root/World/Mobs/ReaperBoss"):
	play_animation_body = get_node(body_path)

func play_dialogue_animation(anim_name: String):
	dialogue_animation_playing = true
	play_animation_body.change_state(anim_name)
	await play_animation_body.anim.animation_finished
	dialogue_animation_playing = false
	
func reset_state():
	player_hp = 10
	player_gold  = 0
	player_alive = true
	gems_collected = 0
	show_player_msg = false
	pet_acquired =false
	jump_has_dmg = false
	jump_has_dbl = false
	unlocked_scare = false
	unlocked_float = false
	unlocked_fly = false
	scare_used = false
	pet_acquired = false
	boss_reaper_room = false
	boss_reaper_room_exit = false

func test_func(text: String):
	print(text)

func gem_collected(n:int = 1):
	for i in n:
		Game.gems_collected += 1
		if Game.gems_collected == 1:
			Game.jump_has_dbl = true 
		if Game.gems_collected == 2:
			Game.jump_has_dmg = true
		if Game.gems_collected == 3:
			unlocked_float = true
		if Game.gems_collected == 4:
			unlocked_fly = true

func get_input_key(name: String):
	return str(InputMap.action_get_events(name)[0].as_text().split(" ")[0])

func start_camera_shake(time: float):
	var camera_tween = get_tree().create_tween()
	camera_tween.tween_method(_camera_shake, 5.0, 1.0, time)
func _camera_shake(intensity: float):
	var camera = get_viewport().get_camera_2d()
	var noise := FastNoiseLite.new()
	var camera_offset = noise.get_noise_1d(Time.get_ticks_msec()) * intensity
	camera.offset = Vector2.ONE * camera_offset
	
