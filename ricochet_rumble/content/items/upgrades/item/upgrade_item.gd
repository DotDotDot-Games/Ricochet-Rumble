extends Sprite2D

@export var upgrade: PlayerUpgrades2

var bullet_count = preload("res://content/items/upgrades/resources/number_of_bullets.tres")
var fire_rate = preload("res://content/items/upgrades/resources/fire_rate.tres")
var damage = preload("res://content/items/upgrades/resources/damage.tres")
var bullet_speed = preload("res://content/items/upgrades/resources/bullet_speed.tres")
var more_bounces = preload("res://content/items/upgrades/resources/more_bounces.tres")
var speed = preload("res://content/items/upgrades/resources/speed.tres")

var random_upgrade = [fire_rate,bullet_count,damage,bullet_speed,more_bounces,speed].pick_random()
#var random_upgrade = [bullet_speed,more_bounces].pick_random()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		for child in body.get_children():
			if child.get_class() == "Node2D":
				random_upgrade.apply(child)
				queue_free()
