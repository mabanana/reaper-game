@tool
extends Node2D
class_name InteractComponent

@export var pos_offset: Vector2
@export var label_text: String
@export var parent: Node2D
@onready var label: Label = $Label
@onready var interact_range: Area2D = $Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	interact_range.body_entered.connect(func(body):
		if body is PlayerBody:
			visible = true
		)
	interact_range.body_exited.connect(func(body):
		if body is PlayerBody:
			visible = false
		)

func _input(event):
	if visible:
		var result = Inputs.handle_input(event)
		if "action" in result and result["action"] == Inputs.PlayerActions.ACTION_F:
			if parent.has_method("interact"):
				parent.interact()
				hide()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = pos_offset
	label.text = label_text

func _on_body_entered(body):
	if body is PlayerBody:
		visible = true
