extends Node

const SAVE_PATH = "res://savegame.bin"

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
				
