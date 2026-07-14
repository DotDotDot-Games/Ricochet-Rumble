@abstract
extends Node

class_name PropertyNode

@export var node: Node
@export var property: StringName

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if not node:
		return
	
	if not property:
		return
		
	var names := property.split(".")
	var prop = node
	
	for val in names:
		prop = prop.get(val)
	
	if not prop:
		return
	
	make_action(prop)

@abstract
func make_action(value: Variant) -> void
