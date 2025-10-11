extends CharacterBody2D

@export var speed = 300.0
@export var health = 8
@export var projectile = load("res://Enemies/cannon_ball.tscn")
var enemy_objective: Node2D

var knockback_velocity: Vector2 = Vector2.ZERO
var knockback_decay: float = 80.0  # higher = faster decay

var computed_velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	rotation_degrees = 180
	await $NavigationAgent2D.ready
	makepath()

func _physics_process(delta: float) -> void:
	var bodies = $Detectionbox.get_overlapping_bodies()
	var nearest = null
	var shortest = INF
	for body in bodies:
		if body is PhysicsBody2D:
			var dist := global_position.distance_to(body.global_position)
			if dist < shortest:
				shortest = dist
				nearest = body
	enemy_objective = get_tree().current_scene.get_node("Enemy_objective")
	if not $Rangebox.get_overlapping_bodies() and $Detectionbox.get_overlapping_bodies():
		$AnimationPlayer.stop()
		if nearest:
			var dir = (nearest.global_position - global_position).normalized()
			if knockback_velocity.length() > 2:
				velocity = knockback_velocity
			else:
				velocity = dir * speed
			look_at(nearest.global_position)
		else:
			velocity = Vector2.ZERO
	elif $Rangebox.get_overlapping_bodies():
		if nearest:
			look_at(nearest.global_position)
		velocity = knockback_velocity
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("Attack")
	else:
		var target = $NavigationAgent2D.get_next_path_position()
		var direction = (target - global_position).normalized()
		
		if knockback_velocity.length() > 2:
			velocity = knockback_velocity
		else:
			velocity = (direction * speed).lerp(computed_velocity, 0.5)
			
		print(velocity)
		
		
		if global_position.distance_to(enemy_objective.global_position) < 20:
			GameScript.health -= 1
			queue_free()
			
		rotation = lerp_angle(rotation, direction.angle(), 0.1)
	
	# Decay Knockback		
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_decay * delta)
		
	move_and_slide()

func makepath():
	enemy_objective = get_tree().current_scene.get_node("Enemy_objective")
	$NavigationAgent2D.target_position = enemy_objective.global_position
	

func take_damage(amount: int, position: Vector2, knockback: int):
	# Damage
	health -= amount
	$Hurt.play()
	# Knockback
	var direction = (global_position - position).normalized()
	knockback_velocity = direction * knockback
	
	# Removing if dead
	if health < 1:
		queue_free()


func _on_timer_timeout() -> void:
	makepath()

func shoot_projectile():
	var new_projectile = projectile.instantiate()
	new_projectile.rotation = $"Shoot Point".global_rotation
	new_projectile.global_position = $"Shoot Point".global_position
	get_tree().get_current_scene().add_child(new_projectile)

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	computed_velocity = velocity
