extends Node

const SAVE_PATH = "res://savegame.bin"

var thumbnails: Dictionary = {
	"Reaper": "res://Sunny-land-files/Graphical Assets/Dialogue Thumbnails/reaper_player_thumbnail.tres",
	"Boss Reaper": "res://Sunny-land-files/Graphical Assets/Dialogue Thumbnails/boss_reaper_thumbnail.tres",
	"Flyer" : "res://Sunny-land-files/Graphical Assets/Dialogue Thumbnails/flyer_thumbnail.tres",
}

func game_reset():
	Game.player_hp = 10
	Game.player_gold = 0

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"player_hp": Game.player_hp,
		"player_gold": Game.player_gold,
		
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.player_hp = current_line["player_hp"]
				Game.player_gold = current_line["player_gold"]
				

static func get_blend_animation(blend_position: Vector2, blend_points: Array):
	var closest = "Idle"
	var dist = 2
	for point in blend_points:
		if blend_position.distance_to(point[0]) <= dist:
			closest = point[1]
			dist = blend_position.distance_to(point[0])
	return closest
