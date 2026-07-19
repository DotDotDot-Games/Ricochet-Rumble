extends Node


@onready var item_node = $"../Items"
var item_upgrade = preload("res://content/items/upgrades/item/upgrade_item.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	while true:
		await get_tree().create_timer(10).timeout

		var item_instance = item_upgrade.instantiate()
		item_instance.global_position = Vector2(randf_range(250, 800), randf_range(140, 640))
		add_child(item_instance)
		var collision_shape = item_instance.get_node("Area2D").get_node("CollisionShape2D")
		collision_shape.set_deferred("disabled", true)
		item_instance.modulate.a = 0
		var tween = create_tween()
		tween.tween_property(item_instance,"modulate:a",1,5)
		await tween.finished
		collision_shape.set_deferred("disabled", false)
		
