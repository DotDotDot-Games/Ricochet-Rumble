extends CenterContainer

class_name WinMenu

const FORMATED_LABEL_TEXT := "Player[color=#%s] %d [/color]wins!"
@onready var label: RichTextLabel = $PanelContainer/VBoxContainer/Label

func win(player: PlayerStats):
	get_tree().paused = true
	
	print("Win Menu: Showing win menu!")
	print("Win Menu: Player id = ", player.player_type)
	var new_text := FORMATED_LABEL_TEXT % [player.color.to_html(), player.player_type+1]
	print("Win Menu: New text = ", new_text)
	label.text = new_text
	
	show()
