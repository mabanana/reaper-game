extends Label

@export var character: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.pet_acquired:
		text = "State : " + character.character_state_machine.current_state.name
		pass
