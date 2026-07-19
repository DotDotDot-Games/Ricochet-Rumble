extends Sprite2D

@export var upgrade: PlayerUpgrades2

var bullet_count = preload("res://content/items/upgrades/resources/number_of_bullets.tres")
var fire_rate = preload("res://content/items/upgrades/resources/fire_rate.tres")
var damage = preload("res://content/items/upgrades/resources/damage.tres")
var bullet_speed = preload("res://content/items/upgrades/resources/bullet_speed.tres")
var more_bounces = preload("res://content/items/upgrades/resources/more_bounces.tres")
var speed = preload("res://content/items/upgrades/resources/speed.tres")
var explosion = preload("res://content/items/upgrades/resources/explosion.tres")
var random_upgrade = [fire_rate,bullet_count,damage,bullet_speed,more_bounces,speed].pick_random()
#var random_upgrade = [explosion].pick_random()
var color = 0	
func _ready():
	if random_upgrade == bullet_count:
		modulate = Color(0.0, 0.648, 0.182, 1.0)
	if random_upgrade == fire_rate:
		modulate = Color(0.96, 0.653, 0.0, 1.0)
	if random_upgrade == damage:
		modulate = Color(1.0, 0.0, 0.0, 1.0)
	if random_upgrade == bullet_speed:
		modulate = Color(0.774, 0.441, 0.0, 1.0)
	if random_upgrade == more_bounces:
		modulate = Color(0.945, 0.0, 0.59, 1.0)
	if random_upgrade == speed:
		modulate = Color(0.286, 0.497, 1.0, 1.0)

func _process(_delta):
	if random_upgrade == explosion:
		modulate = Color.from_hsv(wrapf(color,0,1),0.8,1)
		color += 0.01
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		for child in body.get_children():
			if child.get_class() == "Node2D":
				random_upgrade.apply(child)
				queue_free()
