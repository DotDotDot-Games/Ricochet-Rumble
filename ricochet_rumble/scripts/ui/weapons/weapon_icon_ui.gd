extends PropertyNode

@onready var icon: TextureRect = $Icon
@onready var frontground: ColorRect = $ColorRect

func _verify_self_type() -> bool:
	return (self as Object) is Control

func _set_texture(value: Texture2D) -> void:
	icon.texture = value

func _set_modulate(value: Timer) -> void:
	
	if not value or value.is_stopped():
		frontground.hide()
		return
	
	frontground.show()
	var progress := value.time_left/value.wait_time
	
	var height := icon.size.y
	
	frontground.size.y = floori(height * progress)
	frontground.position.y = height - frontground.size.y
