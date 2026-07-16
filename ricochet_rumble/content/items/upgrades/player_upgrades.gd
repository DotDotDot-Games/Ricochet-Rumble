extends Resource
class_name PlayerUpgrades

enum UpgradeType {
	REGENERATION,
	SHIELD,
	MORE_BULLETS,
	BULLET_SPEED,
	FIRE_RATE,
	MORE_BOUNCES
}
var dict = {
	UpgradeType.REGENERATION: "regeneration",
	UpgradeType.SHIELD: "shield",
	UpgradeType.MORE_BULLETS: "more_bullets",
	UpgradeType.BULLET_SPEED: "bullet_speed",
	UpgradeType.FIRE_RATE: "fire_rate",
	UpgradeType.MORE_BOUNCES: "more_bounces"
}
@export var name : UpgradeType
@export var type : UpgradeType
@export var value : float
var stat:
	get:
		return dict[type]
func apply(node):
	node.stats[stat] += value
	node._update_stats()
