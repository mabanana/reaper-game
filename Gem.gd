extends Area2D
# Called when the node enters the scene tree for the first time.

var id: String = "Gem"

func _ready():
	$AnimatedSprite2D.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player" and not $pickup_gem.playing:
		print("Gem: player picks up a gem")
		$pickup_gem.play()
		Game.gems_collected += 1
		if Game.gems_collected == 2:
			body.jump_damage = 3
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2 (0 , 25), 0.2)
		tween1.tween_property(self, "modulate:a", 0, 0.3)
		tween.tween_callback(queue_free)
		

