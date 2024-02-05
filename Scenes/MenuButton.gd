extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.gems_collected == 2 and get_node("Mobs").get_child_count() == 1:
		text = "End Game"


func _on_pressed():
	get_tree().quit()
