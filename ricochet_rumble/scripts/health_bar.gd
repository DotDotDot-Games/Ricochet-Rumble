extends ProgressBar

@export var player_node : PlayerNode

func _ready():
	
	if player_node:
		max_value =  player_node.stats.health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_node:
		value = player_node.stats.health
