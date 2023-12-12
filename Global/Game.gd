extends Node

var player_hp: int = 10
var player_gold: int = 0
var player_alive: bool = true
var gems_collected: int = 0
var player_global_position: Vector2
var show_player_msg: bool = false
var pet_acquired: bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
