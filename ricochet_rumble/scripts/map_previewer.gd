@tool
extends Control

class_name MapPreviewer

@onready var texture: TextureRect = $Container/TextureRect

@export var world_name: Label
@export var world: PackedScene:
	set(value):
		
		world = value
		
		_update_editor()

@export var world_loaded: Node2D
@export var view: SubViewport

func _ready() -> void:
	
	_update_editor()
	
	if view:
		var world_size := Vector2(
			ProjectSettings.get_setting("display/window/size/viewport_width"),
			ProjectSettings.get_setting("display/window/size/viewport_height")
		)
		var view_size := view.size
		
		var scalation = minf(view_size.x/world_size.x, view_size.y / world_size.y)
		
		world_loaded.scale = Vector2.ONE*scalation
		await get_tree().process_frame
		
		self.texture.texture = view.get_texture()

func _gui_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_on_pressed()

func _on_pressed():
	var game := GameNode.start(world)
	
	get_tree().change_scene_to_node(game)

func _update_editor():
	
	if not world or not view:
		return
	
	if world_loaded:
		world_loaded.free()
	
	world_loaded = world.instantiate()
	world_loaded.process_mode = Node.PROCESS_MODE_DISABLED
	view.add_child(world_loaded)
