@tool
extends Sprite2D

class_name ItemPickableNode

@export var info: ItemPickableData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if not Engine.is_editor_hint():
		return
	
	self.texture = info.texture


# TODO: Implement pickup when the player is implemented.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
