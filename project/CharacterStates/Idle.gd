extends State
class_name MoveState

var blend_points: Dictionary = {
	Vector2(1,0) : "Run",
	Vector2(-1,0) : "Run",
	Vector2(0,1) : "Jump",
	Vector2(0,-1) : "Fall",
	Vector2(0,0) : "Idle",
}

func on_enter():
	pass

func state_process(delta):
	playback.play(get_blend_animation(character.blend_position))
	
func get_blend_animation(blend_position: Vector2):
	var closest = "Idle"
	var dist = 2
	for point in blend_points.keys():
		if blend_position.distance_to(point) <= dist:
			closest = blend_points[point]
			dist = blend_position.distance_to(point)
	return closest
