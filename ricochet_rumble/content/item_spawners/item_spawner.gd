@tool
extends AnimatedSprite2D

class_name ItemSpawnerNode

@onready var timer: Timer = $Timer
@onready var generated_items: Node = $GeneratedItems

## Spawner info
@export var info: ItemSpawnerData:
	set(value):
		
		info = value
		_update_info()

## Item spawned by spawner (null if is not spawned)
@export var item: WorldItemData = null

## Define if spawner is spawning a new item
var spawning := true

const DATABASE: Registry = preload("res://databases/world_items.tres")

## Cache for ID's to use
var IDS: Array[StringName] = []

func _ready():
	if Engine.is_editor_hint():
		return
	
	_start_spawn()

func _process(_delta):
	
	if Engine.is_editor_hint():
		return
	
	if self.sprite_frames.has_animation(&"spawning"):
		if spawning and timer.time_left <= 2.5 and animation != &"spawning":
			self.play("spawning")
		else:
			if not spawning and animation == &"spawning":
				self.play("default")

func _update_info():
	
	if not info:
		return
	
	if not Engine.is_editor_hint():
		print(info.to_dict())
	
	_update_ids()
	self.sprite_frames = info.texture

func _update_ids() -> void:
	
	IDS = DATABASE.filter(&"item_data", Callable(self, "_can_spawn_item"))
	print("IDs: ", IDS)

func _can_spawn_item(data: ItemData):
	
	# TODO: Add only_tags and ignore_tags in filter
	#var in_tags := true
	
	#if info.only_tags.size() > 0:
		#in_tags = data.type in info.only_tags
	
	if info.only.size() > 0:
		return data.id in info.only and data.spawneable
	
	return (not data.id in info.ignore) and data.spawneable

func _start_spawn() -> void:
	spawning = true
	timer.start(info.spawn_time)

func _start_despawn() -> void:
	spawning = false
	
	if info.despawn_time >= 0:
		timer.start(info.despawn_time)

func _on_timer_timeout() -> void:
	
	if spawning:
		_start_despawn()
		
		item = DATABASE.load_entry(IDS.pick_random())
		
		var node := ItemPickableNode.generate(item.pickable_data)
		node.on_picked.connect(_on_pick_item)
		node.global_position = self.global_position
		
		generated_items.add_child(node)
		print("Spawned: ", item.to_dict())
	else:
		_remove_generated_item()
		_start_spawn()

func _remove_generated_item() -> void:
	item = null
	
	for child in generated_items.get_children():
		
		if child is ItemPickableNode:
			child.queue_free()

func _on_pick_item(player: PlayerNode) -> void:
	
	var data := item.item_data
	
	if data is WeaponData:
		player.pick_up_weapon(data)
