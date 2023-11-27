extends Node

@export var character: CharacterBody2D
@export var jump_velocity: int = -400


func jump():
	character.jump_sound.play()
	character.velocity.y = jump_velocity

