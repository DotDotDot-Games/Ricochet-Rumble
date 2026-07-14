@tool
extends Node2D

class_name ItemSpawnerNode

@onready var timer: Timer = $Timer

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

func _update_info():
	
	if not info:
		return
	
	if not Engine.is_editor_hint():
		print(info.to_dict())
	
	_update_ids()

func _update_ids() -> void:
	
	IDS = DATABASE.filter(&"item_data", Callable(self, "_can_spawn_item"))
	print("IDs: ", IDS)

func _can_spawn_item(data: ItemData):
	return (not data.id in info.ignore) and data.spawneable

func _is_id_in_ignore(id: StringName):
	return not id in info.ignore

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
		print("Spawned: ", item.to_dict())
	else:
		item = null
		_start_spawn()
