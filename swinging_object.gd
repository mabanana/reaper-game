extends Node2D

@export var rope: StaticBody2D
@export var angular_speed: int
@export var initial_angle: float
@export var reverse_angle_radians: float
@export var hazard_sprite: CompressedTexture2D
@export var hazard_sprite2d: Sprite2D
@export var damage: int
@export var hit_sound: AudioStreamPlayer

var rotate_direction = 1

func _ready():
	hazard_sprite2d.set_texture(hazard_sprite)
#	if abs(initial_angle) <= PI * reverse_angle_radians:
#		rope_body.rotation = initial_angle

	
func _physics_process(delta):
	if rope.rotation > PI * reverse_angle_radians:
		rotate_direction = -1
	elif rope.rotation < -PI * reverse_angle_radians:
		rotate_direction = 1
	rope.rotation += angular_speed * rotate_direction * delta


		
func deal_damage(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		hit_sound.play()


func _on_hitbox_body_entered(body):
	deal_damage(body)
