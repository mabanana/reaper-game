extends CharacterBody2D
var chase: bool = true
var speed: int = 300
var max_speed: int = 500
var min_speed: int = 100
var offset_x: int = 20
var offset_y: int = -10
var offset: Vector2
@export var sprite_2d: AnimatedSprite2D

func _ready():
	offset = Vector2(offset_x,offset_y)

func _physics_process(delta):
	var displac = (Game.player_global_position + offset - global_position)
	if displac.x > 0:
		offset.x = -offset_x
		sprite_2d.flip_h = false
	elif displac.x < 0:
		offset.x = offset_x
		sprite_2d.flip_h = true

	if Game.pet_acquired:
		if chase:
			velocity = (delta * speed * displac).limit_length(max_speed)
			
		else:
			velocity = (delta * speed * displac).limit_length(min_speed)
		move_and_slide()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
#		global_position = Game.player_global_position + Vector2(0,-10)
		chase = false


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		chase = true
