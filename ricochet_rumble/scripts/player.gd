extends CharacterBody2D

class_name PlayerNode

#constants

@export var stats: PlayerStats
@export var weapon: WeaponNode:
	set(value):
		
		weapon = value
		_setup_weapon()

#vars

var moving := false
var facing := Vector2(1,0)
#scenes
@onready var UI = $"../../UI"
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready():
	sprite.self_modulate = stats.color
	
	
func _physics_process(_delta: float) -> void:
	#print(stats.health)
	if stats.health <= 0:
		kill()
		
	var direction: Vector2

	if stats.player_type == 0:
		direction = Input.get_vector("LEFT_P1", "RIGHT_P1", "UP_P1", "DOWN_P1")
	else :
		direction = Input.get_vector("LEFT_P2", "RIGHT_P2", "UP_P2", "DOWN_P2")
		
	if direction != Vector2.ZERO:
		facing = direction.normalized()
		moving = true
	else:
		moving = false
	
	self.rotation = facing.angle()
	velocity = direction.normalized() * stats.speed
	move_and_slide()

func damage(value):
	stats.health -= value
	
func kill():
	#UI.visible = true
	#for child in UI.get_children():
	#	child.visible = true
	queue_free()

func pick_up_item(data: ItemData) -> void:
	
	if data is WeaponData:
		_pick_up_weapon(data)
		return

func _pick_up_weapon(data: WeaponData) -> void:
	
	var node: WeaponNode = WeaponNode.generate(data)
	
	add_child(node)
	
	if weapon:
		weapon.queue_free()
	
	self.weapon = node

func _setup_weapon() -> void:
	
	if not weapon:
		return
	
	weapon.player = self
	
	weapon.global_position = self.global_position
		
	print("Player Weapon: setted weapon on position ", self.global_position, " and now is: ", weapon.global_position)
