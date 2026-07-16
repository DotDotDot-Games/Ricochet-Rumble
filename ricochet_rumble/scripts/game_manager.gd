extends Node

@onready var player1 = $"../Players/player1"
var fire_rate = preload("res://content/items/upgrades/fire_rate.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("TEST"):
		fire_rate.apply(player1.get_node("WeaponNode"))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
