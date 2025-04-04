extends State
class_name IdleState

var blend_points: Array = [
	[Vector2(1,0), "Run"],
	[Vector2(-1,0), "Run"],
	[Vector2(0,1), "Jump"],
	[Vector2(0,-1), "Fall"],
	[Vector2(0,0), "Idle"],
]

func on_enter():
	pass

func state_process(delta):
	playback.play(Utils.get_blend_animation(character.blend_position, blend_points))
