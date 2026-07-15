extends CharacterBody2D

#constants

var direction := Vector2(1,0)
var health
var speed
var bullet_speed 
var max_bounces
@export var stats: player_stats

#vars

var moving
var facing = Vector2(-1,0)
#scenes
var bullet = preload("res://scenes/bullet.tscn")
@export var bullet_stat : bullet_stats
@onready var bullet_node = $"../../Bullets"
@onready var UI = $"../../UI"

func _ready():
	modulate = stats.color
	health = stats.health
	set_up_variables()
	
	
func _physics_process(delta: float) -> void:
	print(health)
	if health <= 0:
		kill()
	if stats.player_type == 0:
		direction = Input.get_vector("LEFT_P1", "RIGHT_P1", "UP_P1", "DOWN_P1")
		if Input.is_action_just_pressed("SHOOT_P1"):
			shoot()
	else :
		direction = Input.get_vector("LEFT_P2", "RIGHT_P2", "UP_P2", "DOWN_P2")
		if Input.is_action_just_pressed("SHOOT_P2"):
			shoot()
		
	if direction != Vector2.ZERO:
		facing = direction.normalized()
	
	
	
		
	velocity = direction.normalized() * speed
	move_and_slide()
	
	

func shoot():
	var bullet_obj = bullet.instantiate()
	bullet_obj.stats = bullet_stat
	bullet_node.add_child(bullet_obj)
	bullet_obj.global_position = global_position + facing * 40
	bullet_obj.velocity = facing * bullet_speed

func damage(value):
	health -= value
	
func set_up_variables():
	speed = stats.speed
	bullet_speed = bullet_stat.speed
	max_bounces = bullet_stat.max_bounces
	
func kill():
	#UI.visible = true
	#for child in UI.get_children():
	#	child.visible = true
	queue_free()
	
