extends CharacterBody2D

class_name PlayerNode

signal on_die

#constants

@export var stats: PlayerStats
@export var weapon: WeaponNode:
	set(value):
		
		weapon = value
		_setup_weapon()

#vars

var can_move := true
var moving := false
var facing := Vector2(1,0)
#scenes
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready():
	sprite.self_modulate = stats.color
	
	
func _physics_process(_delta: float) -> void:
	if stats.health <= 0:
		kill()
		
	var direction := _get_vector(stats.player_type)
	
	if Input.is_action_pressed(_get_action("STAY", stats.player_type)):
		can_move = false
	else:
		can_move = true

	if direction != Vector2.ZERO:
		facing = direction.normalized()
		moving = true
	else:
		moving = false
	
	self.rotation = facing.angle()
	
	if can_move:
		velocity = direction.normalized() * stats.speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _get_vector(player: int) -> Vector2:
	var idx := str(player+1)
	
	return Input.get_vector("LEFT_P"+idx, "RIGHT_P"+idx, "UP_P"+idx, "DOWN_P"+idx)

func _get_action(action: String, player: int) -> String:
	var idx := str(player+1)
	return action+"_P"+idx

func damage(value):
	animation.play("hitted")
	stats.health -= value
	print(stats.health)
	
func kill():
	on_die.emit()
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
