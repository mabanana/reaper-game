extends Sprite2D
var chase: bool = false
var speed: int = 3

func _process(delta):
	var distance = (Game.player_global_position - global_position).length()
	if chase:
		global_position.x = move_toward(global_position.x, Game.player_global_position.x, speed*delta*distance)
		global_position.y = move_toward(global_position.y, Game.player_global_position.y-10, speed*delta*distance)
	if chase:
		global_position.x = move_toward(global_position.x, Game.player_global_position.x, delta*distance)
		global_position.y = move_toward(global_position.y, Game.player_global_position.y-10, delta*distance)
func _on_area_2d_body_entered(body):
	if body.name == "Player":
#		global_position = Game.player_global_position + Vector2(0,-10)
		chase = false


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		chase = true