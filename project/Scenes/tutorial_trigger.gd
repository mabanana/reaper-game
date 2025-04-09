extends Area2D

@export var tutorial_sprite: AnimatedSprite2D

func _process(delta):
	tutorial_sprite.visible = !Game.scare_used and Game.unlocked_scare
