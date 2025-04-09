extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	value_changed.connect(_on_volume_slider_changed)
	value = AudioServer.get_bus_volume_db(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_volume_slider_changed(value):
	if value == min_value:
		AudioServer.set_bus_volume_db(0, -72)
	else:
		AudioServer.set_bus_volume_db(0, value)
	
	
