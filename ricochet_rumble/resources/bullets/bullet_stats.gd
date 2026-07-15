@tool
extends ShareableResource
class_name BulletStats

@export var _id: String
var id: String:
	get: return _id

@export var name: String:
	set(value):
		
		name = value
		
		if not Engine.is_editor_hint():
			return
		
		_id = name.to_lower().replace(" ", "_")
@export var speed : float
@export var bounces : LimitedValue
@export var damage : float
@export var texture: Texture2D

@export_file("*.tscn") var scene: String
