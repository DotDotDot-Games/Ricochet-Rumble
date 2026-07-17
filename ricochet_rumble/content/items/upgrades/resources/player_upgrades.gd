extends Resource
class_name PlayerUpgrades2

enum UpgradeType {
	REGENERATION,
	SHIELD,
	MORE_BULLETS,
	BULLET_SPEED,
	FIRE_RATE,
	MORE_BOUNCES,
	DAMAGE
}
var dict = {
	UpgradeType.REGENERATION: "regeneration",
	UpgradeType.SHIELD: "shield",
	UpgradeType.DAMAGE: "damage",
	UpgradeType.MORE_BULLETS: "bullets_per_shot",
	UpgradeType.BULLET_SPEED: "speed",
	UpgradeType.FIRE_RATE: "fire_rate",
	UpgradeType.MORE_BOUNCES: "_current_value"
}
@export var name : UpgradeType
@export var type : UpgradeType
@export var value : float
var stat:
	get:
		return dict[type]
		 
func apply(node):
	
	if name in [UpgradeType.REGENERATION, UpgradeType.MORE_BULLETS,UpgradeType.FIRE_RATE]:
		print("Before " + str(stat)+" ", node.stats[stat])
		node.stats[stat] += value
		node._update_stats()
		print("After " + str(stat)+" ", node.stats[stat])
	elif name in [UpgradeType.BULLET_SPEED,UpgradeType.DAMAGE]:
		print("Before " + str(stat)+" ", node.stats.bullet[stat])
		node.stats.bullet[stat] += value
		print("After " + str(stat)+" ", node.stats.bullet[stat])
	elif name in [UpgradeType.MORE_BOUNCES]:
		print("Before " + str(stat)+" ", node.stats.bullet.bounces[stat])
		node.stats.bullet.bounces[stat] += value
		print("After " + str(stat)+" ", node.stats.bullet.bounces[stat])
