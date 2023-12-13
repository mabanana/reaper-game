extends CharacterBody2D
var chase: bool = true
var speed: int = 300
var max_speed: int = 500
var min_speed: int = 100
var offset_x: int = 20
var offset_y: int = -10
var offset: Vector2
@export var sprite_2d: AnimatedSprite2D
@export var character_state_machine: CharacterStateMachine

func _ready():
	offset = Vector2(offset_x,offset_y)

func _physics_process(delta):
	var displac = (Game.player_global_position + offset - global_position)

	if Game.pet_acquired:
		if displac.x > 0:
			offset.x = -offset_x
			sprite_2d.flip_h = false
		else:
			offset.x = offset_x
			sprite_2d.flip_h = true

		if character_state_machine.current_state.name == "Chase":
			velocity = (delta * speed * displac).limit_length(max_speed)
			
		elif character_state_machine.current_state.name == "Idle":
			velocity = (delta * speed * displac).limit_length(min_speed)
		
		move_and_slide()
		character_state_machine.state_machine_process(delta)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		print("Floater: Player entered area")
		character_state_machine.current_state.next_state = character_state_machine.states["Idle"]
		print(character_state_machine.current_state.next_state.name)


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		character_state_machine.current_state.next_state = character_state_machine.states["Chase"]
