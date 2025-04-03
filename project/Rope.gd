extends StaticBody2D
var movement: int = 1
var clockwise: int = 1


func _physics_process(delta):
	rotation += movement * clockwise * delta
	print(rotation)
	if abs(rotation) > PI/2:
		clockwise *= -1
