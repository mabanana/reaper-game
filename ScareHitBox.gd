extends Area2D
@export var sprite2d: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	monitorable = false
	monitoring = true
	print("ScareAbility: Ready")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_scare_sprite_animation_finished():
	queue_free()

func _on_body_entered(body):
	if body.has_method("scare"):
		body.scare(get_parent())
