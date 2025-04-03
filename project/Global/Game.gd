extends Node

var player_hp: int = 10
var player_gold: int = 0
var player_alive: bool = true
var jump_has_dmg: bool = false
var jump_has_dbl: bool = false
var unlocked_scare: bool = false
var gems_collected: int = 0
var player_global_position: Vector2
var show_player_msg: bool = false
var pet_acquired: bool = true
var boss_reaper_room: bool = false
var boss_reaper_room_exit: bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var play_animation_body: CharacterBody2D


func set_animation_body(body_path: String):
	play_animation_body = get_node("/root/World/Mobs/ReaperBoss")

func play_dialogue_animation(anim_name: String):
	play_animation_body.change_state(anim_name)
	
func reset_state():
	player_hp = 10
	player_gold  = 0
	player_alive = true
	gems_collected = 0
	show_player_msg = false
	pet_acquired =false

func test_func(text: String):
	print(text)

func gem_collected(n:int = 1):
	for i in n:
		Game.gems_collected += 1
		if Game.gems_collected == 1:
			Game.jump_has_dbl = true 
		if Game.gems_collected == 2:
			Game.jump_has_dmg = true

func get_input_key(name: String):
	return str(InputMap.action_get_events(name)[0].as_text().split(" ")[0])
