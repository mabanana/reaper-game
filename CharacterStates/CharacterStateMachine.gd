extends Node

class_name CharacterStateMachine

@export var current_state : State
@export var character: CharacterBody2D
@export var animation_tree: AnimationTree
@export var death_state : State
@export var hurt_state : State
var states : Array[State]


func _ready():
	for child in get_children():
		if child is State:
				states.append(child)
				# Set the state up with what they need to function
				child.character = character
				child.playback = animation_tree["parameters/playback"]
				child.death_state = death_state
				child.hurt_state = hurt_state
		else:
			push_warning("CharacterStateMachine:  " + child.name + " is not a State for CharacterStateMachine")


func state_machine_process(delta):
	if current_state.next_state != null:
		switch_states(current_state.next_state)
	current_state.state_process(delta)


func is_can_move():
	return current_state.can_move


func switch_states(new_state):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
	current_state = new_state
	current_state.on_enter()

func _input(event : InputEvent):
	current_state.state_input(event)
