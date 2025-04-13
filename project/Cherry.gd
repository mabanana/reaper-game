extends Area2D
var is_on_floor: bool = false
var is_picked: bool = false
var id: String = "Cherry"
# Called when the node enters the scene tree for the first time.
func _ready():
	$spawn_cherry.play()
	$AnimatedSprite2D.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor:
		position.y += 50 * delta
		pass


func _on_body_entered(body):
	if body.get_parent().name == "Player" and not is_picked:
		
		if body.has_method("pickup"):
			for cherry in get_parent().get_children():
				if cherry.id == "Cherry" and (Game.player_global_position - cherry.global_position).length():
					if cherry.global_position != global_position:
						body.pickup(cherry.global_position)
						print("Cherry: cherry location given by cherry at " + str(cherry.global_position) )


		print("Cherry: " + body.name + " picks up a Cherry at " + str(global_position))
		is_picked = true
		$pickup_cherry.play()
		Game.player_gold += 5
		print("Cherry: player +5 gold")
		if Game.player_hp < 10:
			Game.player_hp += 1
			print("Cherry: player heals 1 health")
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2 (0 , 25), 0.2)
		tween1.tween_property(self, "modulate:a", 0, 0.3)
		tween.tween_callback(queue_free)
	elif body is TileMapLayer:
		is_on_floor = true
		
	
	

func _on_body_exited(body):
	if body is TileMapLayer:
		is_on_floor = false
