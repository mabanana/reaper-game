extends TextureProgressBar
var denom

# Called when the node enters the scene tree for the first time.
func _ready():
	denom = $"..".health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = $"..".health * (max_value/denom)
