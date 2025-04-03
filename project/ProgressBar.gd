extends ProgressBar
@export var character: CharacterBody2D
var denom: int

func _ready():
	denom = character.health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = character.health * (max_value/denom)
