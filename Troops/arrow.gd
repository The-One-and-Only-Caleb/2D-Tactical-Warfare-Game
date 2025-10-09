extends CharacterBody2D

const speed = 300



func _physics_process(delta: float) -> void:
	var nearest_body = get_nearest_body()
	if nearest_body:
		var target_position = nearest_body.global_position
		
		velocity += (target_position - global_position).normalized() * speed
	else:
		print("arrow couldn't find target")
		$"Grace Timer".start()
		
	move_and_slide()

	

func get_nearest_body():
	var bodies = $DetectionBox.get_overlapping_bodies()
	var nearest = null
	var min_distance = INF

	for body in bodies:
		var distance = global_position.distance_to(body.global_position)
		if distance < min_distance:
			min_distance = distance
			nearest = body
			
	print(nearest)
	return nearest


func _on_destruction_box_body_entered(body: Node2D) -> void:
	print("arrow hit object")
	queue_free()


func _on_grace_timer_timeout() -> void:
	var nearest_body = get_nearest_body()
	if not nearest_body:
		queue_free()
