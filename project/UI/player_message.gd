extends Control

var text: String

func _ready():
	print("PlayerMessage: ready")
#	$Timer.start(5)
	if Game.gems_collected == 1:
		text = "You can now Double Jump!!"
	elif Game.gems_collected == 2:
		text = "Jumps do more Damage!!"
	$pickup_gem.text = text


func _on_timer_timeout():
	print("PlayerMessage: queue free")
	self.queue_free()

