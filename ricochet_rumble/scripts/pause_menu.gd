extends CenterContainer

class_name PauseMenu
@export var restart: Button
@export var map: PackedScene

func _ready():
	
	if not restart.pressed.is_connected(_on_press_restart):
		restart.pressed.connect(_on_press_restart)

func pause() -> void:
	
	self.show()
	get_tree().paused = true

func resume() -> void:
	self.hide()
	get_tree().paused = false

func _on_press_restart():
	
	var node := GameNode.start(map)
	
	var tree := get_tree()
	
	tree.change_scene_to_node(node)
	
	await tree.process_frame
	
	tree.paused = false
