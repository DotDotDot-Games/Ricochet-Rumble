extends ShareableResource

class_name ItemSpawnerData

## Item spawn time
@export var spawn_time := 5.0

## Item despawn time (Leave at -1.0 if you don't want them to despawn)
@export var despawn_time := -1.0

## WorldItems that the spawner will not spawn
@export var ignore: Array[StringName] = []
