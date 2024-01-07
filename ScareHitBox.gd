extends Area2D
@export var sprite2d: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	monitorable = false
	monitoring = false
	sprite2d.texture = null
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.monitoring:
		print("ScareSprite: Area2D is monitoring")

func flip_sprite(is_flip: bool):
	print("ScareSprite: The player is facing " + str(is_flip))
	sprite2d.flip_h = is_flip
#	sprite2d.set_transform(Vector2(22*int(is_flip),2))
