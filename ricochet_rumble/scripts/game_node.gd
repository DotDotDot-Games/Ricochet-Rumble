extends Node2D

class_name GameNode

@export var players: Array[PlayerNode] = []
@onready var win_menu: WinMenu = $CanvasLayer/WinMenu
@onready var pause_menu: PauseMenu = $CanvasLayer/PauseMenu
var _can_pause := true

func _ready():
	print("Game Node: players = ", players)
	var world: World2D = $CanvasLayer2/HBoxContainer/SubViewportContainer/SubViewport.find_world_2d()
	$CanvasLayer2/HBoxContainer/SubViewportContainer2/SubViewport.world_2d = world
	
	players.sort_custom(Callable(self, _sort_by_id.get_method()))
	
	for player in players:
		if not player.on_die.is_connected(_on_die_player):
			player.on_die.connect(_on_die_player.bind(player))

func _sort_by_id(a: PlayerNode, b: PlayerNode) -> bool:
	return a.stats.player_type > b.stats.player_type

func _verify_win() -> void:
	
	if players.size() > 1:
		return
	
	var winner: PlayerNode = players[0]
	
	win_menu.win(winner.stats)

func _on_die_player(player: PlayerNode):
	
	var winner: PlayerNode = players[1-player.stats.player_type]
	
	win_menu.win(winner.stats)
	_can_pause = false

func _input(event: InputEvent) -> void:
	
	if event.is_action("PAUSE"):
		if _can_pause:
			pause_menu.pause()
		
