extends CharacterBody2D

const speed = 300

var destroying = false


func _physics_process(delta: float) -> void:
	if destroying == true:
		queue_free()
	var nearest_body = get_nearest_body()
	if nearest_body:
		look_at(nearest_body.global_position)
		var target_position = nearest_body.global_position
		
		var collision = move_and_collide((target_position - global_position).normalized() * speed * delta)
		if collision:
			var collider = collision.get_collider()
			if collider is PhysicsBody2D or collider is Area2D:
				if collision.get_collider().collision_layer & (1 << 3):
					return  # Ignore layer 4
				destroying = true
			else:
				queue_free()
				# This will happen if projectile collides with tilemap

		
	else:
		if !$"Grace Timer".time_left > 0:
			$"Grace Timer".start()
		

	

func get_nearest_body():
	var bodies = $DetectionBox.get_overlapping_bodies()
	var nearest = null
	var min_distance = INF

	for body in bodies:
		var distance = global_position.distance_to(body.global_position)
		if distance < min_distance:
			min_distance = distance
			nearest = body
	return nearest

func _on_grace_timer_timeout() -> void:
	var nearest_body = get_nearest_body()
	if not nearest_body:
		queue_free()
