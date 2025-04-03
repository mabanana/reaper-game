extends RectDialogueTrigger

func _process(delta):
	if Game.boss_reaper_room:
		trigger_condition = true
