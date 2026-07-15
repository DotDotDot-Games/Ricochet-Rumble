extends CharacterBody2D

var max_bounces

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	var collision = move_and_collide(velocity)
	if collision:
		
		
		velocity = velocity.bounce(collision.get_normal())
		var collider = collision.get_collider()
		
		if collider.is_in_group("players"):
			collider.kill()
			queue_free()
		if max_bounces == 0:
			queue_free()
		max_bounces -= 1
