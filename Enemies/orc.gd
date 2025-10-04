extends CharacterBody2D

var speed = 300.0
var health = 4
var enemy_objective: Node2D

func _ready() -> void:
	rotation_degrees = 180
	await $NavigationAgent2D.ready
	makepath()

func _physics_process(delta: float) -> void:
	var enemy_objective = get_tree().current_scene.get_node("Enemy_objective")
	if not $Rangebox.get_overlapping_bodies() and $Detectionbox.get_overlapping_bodies():
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
	elif $Rangebox.get_overlapping_bodies():
		velocity = Vector2.ZERO
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("Attack")
	else:
		var target = $NavigationAgent2D.get_next_path_position()
		var direction = (target - global_position).normalized()

		velocity = direction * speed
		
		if global_position.distance_to(enemy_objective.global_position) < 20:
			GameScript.health -= 1
			queue_free()


		rotation = lerp_angle(rotation, direction.angle(), 0.1)
	move_and_slide()

func makepath():
	enemy_objective = get_tree().current_scene.get_node("Enemy_objective")
	$NavigationAgent2D.target_position = enemy_objective.global_position
	



func _on_hurtbox_area_entered(area: Area2D) -> void:
	health -= 1
	if health < 1:
		queue_free()


func _on_timer_timeout() -> void:
	makepath()
