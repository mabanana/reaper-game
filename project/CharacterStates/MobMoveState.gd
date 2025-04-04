extends State

class_name MobIdleState
@export var move_animation: String = "Idle"
@export var fall_animation: String = "Idle"
@export var jump_animation: String = "Idle"
@export var idle_animation: String = "Idle"
var blend_points: Array = [
	[Vector2(1,0), move_animation],
	[Vector2(-1,0), move_animation],
	[Vector2(0,1), jump_animation],
	[Vector2(0,-1), fall_animation],
	[Vector2(0,0), "Idle"],
]

func state_process(delta):
	character.velocity.x = 0
	playback.play(Utils.get_blend_animation(character.blend_position, blend_points))


func on_enter():
	pass


#func on_exit():
#	if next_state == get_parent().states["Attack"]:
#		playback.play("Attack")
