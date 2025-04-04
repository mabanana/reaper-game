extends Node

class_name CharacterStateMachine

@export var current_state : State
@export var character: CharacterBody2D
@export var animation_player: AnimationPlayer
var states : Dictionary = {}


func _ready():
	for child in get_children():
		if child is State:
				states[child.name] = child
				# Set the state up with what they need to function
				child.character = character
				child.playback = animation_player
		else:
			push_warning("CharacterStateMachine:  " + child.name + " is not a State for CharacterStateMachine")

func state_machine_process(delta):
	if current_state.next_state != null:
		print(str(character.name) + " has entered " + str(current_state.next_state.name) + " from " + str(current_state.name))
		switch_states(current_state.next_state)
	current_state.state_process(delta)


func is_can_move():
	return current_state.can_move

func has_gravity():
	return current_state.has_gravity
	
func is_can_attack():
	return current_state.can_attack

func switch_states(new_state):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
	current_state = new_state
	current_state.on_enter()
	
