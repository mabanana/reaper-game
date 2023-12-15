extends CharacterBody2D
var chase: bool = true
var speed: int = 300
var max_speed: int = 500
var min_speed: int = 100
var offset_x: int = 20
var offset_y: int = -10
var offset: Vector2
var pickup_location: Vector2
var pickup_list: Dictionary = {}
@export var sprite_2d: AnimatedSprite2D
@export var character_state_machine: CharacterStateMachine

func _ready():
	offset = Vector2(offset_x,offset_y)

func _physics_process(delta):
	var displac = (Game.player_global_position + offset - global_position)
	var character_direction = Input.get_axis("move_left", "move_right")
	if Game.pet_acquired:
		if velocity.x > 0:
			sprite_2d.flip_h = false
		elif velocity.x < 0:
			sprite_2d.flip_h = true

		if character_direction == -1:
			offset.x = offset_x
		elif character_direction == 1:
			offset.x = -offset_x

		if character_state_machine.current_state.name == "Chase":
			velocity = (delta * speed * displac).limit_length(max_speed)
			
		elif character_state_machine.current_state.name == "Idle":
			velocity = (delta * speed * displac).limit_length(min_speed)
		
		elif character_state_machine.current_state.name == "Pickup":
			displac = pickup_location - global_position
			velocity = (delta * speed * displac).limit_length(max_speed)
			if displac.length() < 10:
				character_state_machine.current_state.next_state = character_state_machine.states["Chase"]
		
		move_and_slide()
		character_state_machine.state_machine_process(delta)

#func _on_area_2d_body_entered(body):
#	if body.name == "Player":
#		character_state_machine.current_state.next_state = character_state_machine.states["Idle"]
#
#
#
#func _on_area_2d_body_exited(body):
#	if body.name == "Player":
#		character_state_machine.current_state.next_state = character_state_machine.states["Chase"]


func _on_area_2d_area_entered(area):
	if area.get_parent().name == "Collectables":
		if area.id == "Cherry":
			pickup(area.global_position)



func _on_area_2d_area_exited(area):
	pass # Replace with function body.


func pickup(location):
	print("Floater: Cherry located at " + str(location))
	character_state_machine.current_state.next_state = character_state_machine.states["Pickup"]
	pickup_location = location

