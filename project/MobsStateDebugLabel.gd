extends Label

@export var character: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "State : " + character.current_state().name + ", " + character.anim.current_animation
