@tool
extends Node2D

class_name GameNode

@export var map_spawner: SubViewport
@export var loaded_map: PackedScene
@export var map: GameMap
@export var players: Array[PlayerNode] = []
@export var win_menu: WinMenu
@export var pause_menu: PauseMenu
var _can_pause := true

static func start(_map: PackedScene) -> GameNode:
	
	var scene: GameNode = preload("res://scenes/game.tscn").instantiate()
	
	scene.loaded_map = _map
	scene.map = _map.instantiate()
	scene.map_spawner.add_child(scene.map)
	scene.pause_menu.map = _map
	
	return scene

func _ready():
	print("Game Node: players = ", players)
	var world: World2D = $CanvasLayer2/HBoxContainer/SubViewportContainer/SubViewport.find_world_2d()
	$CanvasLayer2/HBoxContainer/SubViewportContainer2/SubViewport.world_2d = world
	
	if Engine.is_editor_hint():
		return
	
	players.sort_custom(Callable(self, _sort_by_id.get_method()))
	
	var spawners := map.player_spawners.get_children()
	
	for player in players:
		if not player.on_die.is_connected(_on_die_player):
			player.on_die.connect(_on_die_player.bind(player))
		
		var spawn: Node2D = spawners[player.stats.player_type]
		
		player.global_position = spawn.global_position

func _sort_by_id(a: PlayerNode, b: PlayerNode) -> bool:
	return a.stats.player_type < b.stats.player_type

func _on_die_player(player: PlayerNode):
	
	var winner: PlayerNode = players[1-player.stats.player_type]
	
	win_menu.win(winner.stats)
	_can_pause = false

func _input(event: InputEvent) -> void:
	
	if event.is_action("PAUSE"):
		if _can_pause:
			pause_menu.pause()
		
