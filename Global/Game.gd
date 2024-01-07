extends Node

var player_hp: int = 10
var player_gold: int = 0
var player_alive: bool = true
var gems_collected: int = 0
var player_global_position: Vector2
var show_player_msg: bool = false
var pet_acquired: bool = false
var boss_reaper_room: bool = false
var boss_reaper_room_exit: bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

	
func reset_state():
	player_hp = 10
	player_gold  = 0
	player_alive = true
	gems_collected = 0
	show_player_msg = false
	pet_acquired =false

func test_func(text: String):
	print(text)
