extends CharacterBody2D

#constants
var speed := 300
var direction := Vector2(1,0)
var bullet_speed = 8

#vars
var moving
var facing = Vector2(-1,0)
#scenes
var bullet = preload("res://scenes/bullet.tscn")
@onready var bullet_node = $"../Bullets"
@onready var UI = $"../UI"

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	
	if direction != Vector2.ZERO:
		facing = direction.normalized()
	
	
	
	if Input.is_action_just_pressed("SHOOT"):
		shoot()
		
	velocity = direction.normalized() * speed
	move_and_slide()
	

func shoot():
	var bullet_obj = bullet.instantiate()
	bullet_node.add_child(bullet_obj)
	bullet_obj.global_position = global_position + facing * 40
	bullet_obj.velocity = facing * bullet_speed
	
func kill():
	UI.visible = true
	for child in UI.get_children():
		child.visible = true
	queue_free()
	
