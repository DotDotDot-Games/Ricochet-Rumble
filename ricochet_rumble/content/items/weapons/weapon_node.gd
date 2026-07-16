@tool
extends Node2D

class_name WeaponNode

## You can keep this empty
@export var bullets_container: Node

## Muzzle of the weapon
@onready var muzzle: Node2D = $Muzzle
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var fire_cooldown: Timer = $Timer

@export var player: PlayerNode
@export var stats: WeaponData:
	set(value):
		
		if value:
			value = value.duplicate(true)
			
		stats = value
		
		if Engine.is_editor_hint():
			_update_stats()

var can_fire := true

static func generate(data: WeaponData) -> WeaponNode:
	return load(data.scene).instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	_update_stats()
	
	if Engine.is_editor_hint():
		return
		
	print("Generated weapon: ", stats.to_dict())
	if not bullets_container:
		bullets_container = $"/root/Game/Bullets"

func _update_stats():
	if not stats:
		return
	
	print(sprite)
	sprite.sprite_frames = stats.texture
	fire_cooldown.wait_time = stats.fire_rate

func use() -> void:
	
	if Engine.is_editor_hint():
		return
	
	var bullet := BulletNode.generate(stats.bullet)
	bullet.global_position = muzzle.global_position
	bullet.global_rotation = muzzle.global_rotation
	bullet.velocity = muzzle.global_transform.x * stats.bullet.speed
	
	bullets_container.add_child(bullet)
	print("Bullet spawned!")

func _physics_process(_delta: float) -> void:
	
	var action := "SHOOT_P" + str(player.stats.player_type+1)
		
	if can_shoot(action):
		use()
		fire_cooldown.start()

func can_shoot(action: String) -> bool:
	
	print("Input Shoot: can fire? ", can_fire)
	if not can_fire:
		return false
	
	print("Input Shoot: fire_cooldown = ", fire_cooldown.time_left)
	if not fire_cooldown.is_stopped():
		return false
	
	if stats.is_automatic:
		return Input.is_action_pressed(action)
	else:
		return Input.is_action_just_pressed(action)
