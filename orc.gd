extends CharacterBody2D

var speed = 300.0
var health = 4

func _physics_process(delta: float) -> void:
	if not $Rangebox.get_overlapping_bodies():
		$AnimationPlayer.stop()
		var bodies = $Detectionbox.get_overlapping_bodies()
		var nearest = null
		var shortest = INF
		for body in bodies:
			if body is PhysicsBody2D:
				var dist := global_position.distance_to(body.global_position)
				if dist < shortest:
					shortest = dist
					nearest = body
		if nearest:
			var dir = (nearest.global_position - global_position).normalized()
			velocity = dir * speed
			look_at(nearest.global_position)
		else:
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("Attack")
	move_and_slide()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	health -= 1
	if health < 1:
		queue_free()
