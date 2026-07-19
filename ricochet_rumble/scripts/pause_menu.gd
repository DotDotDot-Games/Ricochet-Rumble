extends CenterContainer

class_name PauseMenu

func pause() -> void:
	self.show()
	get_tree().paused = true

func resume() -> void:
	self.hide()
	get_tree().paused = false
