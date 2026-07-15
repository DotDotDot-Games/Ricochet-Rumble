extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	var collision = move_and_collide(velocity)
	if collision:
		
		velocity = velocity.bounce(collision.get_normal())
		var collider = collision.get_collider()
		
		if collider.is_in_group("players"):
			collider.kill()
