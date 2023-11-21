extends Control



func _on_timer_timeout():
	print("delete message")
	self.queue_free()
