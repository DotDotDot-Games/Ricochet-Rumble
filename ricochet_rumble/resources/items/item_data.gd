@tool
extends ShareableResource

class_name ItemData

enum Type {
	WEAPON,
	UPGRADE
}

## Item id, is equal than the registry string_id
@export var _id: String
var id:
	get: return _id

@export var name: String:
	set(value):
		
		name = value
		
		if not Engine.is_editor_hint():
			return
		
		_id = name.to_lower().replace(" ", "_")

@export var description: String

## Icon of item in UI
@export var icon: Texture2D

## Texture of item in hand
@export var texture: SpriteFrames

## Define if the item can spawn in spawners
@export var spawneable := true

## Define the type of the item (for the spawners)
@export var type: Type
