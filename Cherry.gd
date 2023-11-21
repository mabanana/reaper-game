extends Area2D
var is_on_floor: bool = false
var is_picked: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$spawn_cherry.play()
	$AnimatedSprite2D.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor:
		position.y += 50 * delta
	else:
		position.y -= 1 * delta


func _on_body_entered(body):
	if body.name == "Player" and not is_picked:
		is_picked = true
		$pickup_cherry.play()
		Game.player_gold += 5
		if Game.player_hp < 10:
			Game.player_hp += 1
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2 (0 , 25), 0.2)
		tween1.tween_property(self, "modulate:a", 0, 0.3)
		tween.tween_callback(queue_free)
	elif body.name == "TileMap":
		is_on_floor = true

func _on_body_exited(body):
	if body.name == "TileMap":
		is_on_floor = false
