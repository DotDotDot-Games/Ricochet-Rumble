extends Node


@onready var item_node = $"../Items"
var item_upgrade = preload("res://content/items/upgrades/item/upgrade_item.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	while true:
		await get_tree().create_timer(1).timeout

		var item_instance = item_upgrade.instantiate()
		item_instance.global_position = Vector2(randf_range(60, 1100), randf_range(60, 600))
		add_child(item_instance)
