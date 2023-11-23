extends Node

class_name MobCharacterStateMachine

@export var current_state : State
@export var character: CharacterBody2D
@export var anim: AnimatedSprite2D
@export var death_state : State
@export var spawn_state : State
var states : Array[State]


func _ready():
	for child in get_children():
		if child is State:
				states.append(child)
				# Set the state up with what they need to function
				child.character = character
				child.anim = anim
				child.death_state = death_state
		else:
			push_warning("CharacterStateMachine:  " + child.name + " is not a State for CharacterStateMachine")


func _physics_process(delta):
	if current_state != null:
		if current_state.next_state != null:
			switch_states(current_state.next_state)
		current_state.state_process(delta)


func switch_states(new_state):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
	current_state = new_state
	current_state.on_enter()

