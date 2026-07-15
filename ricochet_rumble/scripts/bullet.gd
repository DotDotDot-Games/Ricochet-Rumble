extends CharacterBody2D


var stats

var damage
var speed
var max_bounces
func _ready() -> void:
	set_up_variables()
	
func set_up_variables():
	damage = stats.damage
	speed = stats.speed
	max_bounces = stats.max_bounces
func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	var collision = move_and_collide(velocity)
	if collision:
		
		
		velocity = velocity.bounce(collision.get_normal())
		var collider = collision.get_collider()
		
		if collider.is_in_group("players"):
			collider.damage(stats.damage)
			queue_free()
		if max_bounces == 0:
			queue_free()
		max_bounces -= 1
