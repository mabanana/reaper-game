extends RectDialogueTrigger
@export var coll: StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.boss_reaper_room:
		trigger_condition = false
		coll.position.y += 70
		queue_free()
