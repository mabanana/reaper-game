extends Control
class_name ControlsListController
@export var actions_list: ItemList
@export var input_list: ItemList

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$Button.pressed.connect(func ():
		hide()
		)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
