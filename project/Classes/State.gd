extends Node

class_name State

@export var can_move: bool = true
@export var has_gravity: bool = true
@export var can_attack: bool = true

var character : CharacterBody2D
var next_state: State
var playback: AnimationPlayer
var state_machine: StateMachine

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass
