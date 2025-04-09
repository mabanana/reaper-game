extends Area2D

@export var message_label: Label
# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body is PlayerBody and Game.unlocked_scare and Game.player_gold == 0:
		message_label.show()

func _on_body_exited(body):
	if body is PlayerBody and message_label.visible:
		message_label.hide()
