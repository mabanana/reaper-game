extends Control
@export var despawn_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	despawn_timer.paused = true
	despawn_timer.start(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.show_player_msg:
		despawn_timer.paused = false


func _on_timer_timeout():
	Game.show_player_msg = false
	despawn_timer.paused = true
	despawn_timer.start(3)
	
