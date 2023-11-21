extends Area2D
var is_on_floor = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_on_floor == false:
		position.y += 100 * delta


func _on_body_entered(body):
	if body.name == "Player":
		Game.player_gold += 5
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2 (0 , 25), 0.2)
		tween1.tween_property(self, "modulate:a", 0, 0.3)
		tween.tween_callback(queue_free)
	elif body.name == "TileMap":
		is_on_floor = true
	else:
		print(body.name)
