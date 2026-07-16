extends CharacterBody2D

class_name PlayerNode

#constants

@export var stats: PlayerStats
@export var weapon: WeaponNode:
	set(value):
		
		weapon = value
		
		if weapon:
			weapon.player = self
			weapon.global_position = self.global_position

#vars

var moving
var facing = Vector2(-1,0)
#scenes
@onready var UI = $"../../UI"
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	sprite.self_modulate = stats.color
	
	
func _physics_process(_delta: float) -> void:
	print(stats.health)
	if stats.health <= 0:
		kill()
		
	var direction: Vector2

	if stats.player_type == 0:
		direction = Input.get_vector("LEFT_P1", "RIGHT_P1", "UP_P1", "DOWN_P1")
	else :
		direction = Input.get_vector("LEFT_P2", "RIGHT_P2", "UP_P2", "DOWN_P2")
		
	if direction != Vector2.ZERO:
		facing = direction.normalized()
	
	self.rotation = direction.angle()
	velocity = direction.normalized() * stats.speed
	move_and_slide()

func damage(value):
	stats.health -= value
	
func kill():
	#UI.visible = true
	#for child in UI.get_children():
	#	child.visible = true
	queue_free()
