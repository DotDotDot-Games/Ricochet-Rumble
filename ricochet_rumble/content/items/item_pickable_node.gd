@tool
extends Sprite2D

class_name ItemPickableNode

## Execute when the item is picked up
signal on_picked(player_who_pickup: PlayerNode)

@export var info: ItemPickableData

## Define the time you need to stay still to grab the item
@export var time_to_pickup := 1.0

## Store the player IDs within the timers and track the time they remain stationary.
var timers: Dictionary[PlayerNode, float] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if not Engine.is_editor_hint():
		return
	
	if info:
		self.texture = info.texture

static func generate(data: ItemPickableData) -> ItemPickableNode:
	
	var node: ItemPickableNode = load(data.scene).instantiate()
	
	return node

# TODO: Implement pickup when the player is implemented.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Engine.is_editor_hint():
		return
	
	for player in timers:
		if not player.moving:
			timers[player] -= delta
		
		if timers[player] <= 0:
			pick(player)
			break

func _on_player_entered(body: Node2D) -> void:
	
	if Engine.is_editor_hint():
		return
	
	if body is PlayerNode:
		timers[body as PlayerNode] = time_to_pickup

func _on_player_exited(body: Node2D) -> void:
	
	if Engine.is_editor_hint():
		return
	
	if body is PlayerNode:
		timers.erase(body)

func pick(player: PlayerNode) -> void:
	on_picked.emit(player)
	queue_free()
