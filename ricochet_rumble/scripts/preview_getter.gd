@tool
extends TextureRect

@export var sub_viewport: SubViewport

func _ready() -> void:
	
	if sub_viewport:
		self.texture = sub_viewport.get_texture()
