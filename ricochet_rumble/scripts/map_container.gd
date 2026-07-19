@tool
extends GridContainer

class_name MapContainer

const MAPS: Registry = preload("res://databases/maps.tres")
const MAP_PREVIEWER = preload("res://scenes/map_previewer.tscn")

func _ready():
	
	for id in MAPS.get_all_string_ids():
		var node: MapPreviewer = MAP_PREVIEWER.instantiate()
		node.world_name.text = str(id)
		node.world = MAPS.load_entry(id)
		add_child(node)
