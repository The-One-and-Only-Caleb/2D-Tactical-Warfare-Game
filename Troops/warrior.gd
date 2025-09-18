extends CharacterBody2D


const speed = 400.0

var troop_number
var total_troop_count

var start_point
var end_point
@export var health = 5

func init(number, count, start, end) -> void:
	troop_number = number
	total_troop_count = count
	start_point = start
	end_point = end

func _physics_process(delta: float) -> void:
	# Movement
	var start_point = get_parent().get_point_position(0)
	var end_point = get_parent().get_point_position(1)
	# Calculate how far along the segment this troop should be placed
	var placement_ratio = 1 - float(troop_number) / (total_troop_count - 1)
	# Use linear interpolation to find the exact position
	var target_position = start_point.lerp(end_point, placement_ratio)
	var to_target = target_position - position
	var distance = to_target.length()
	if distance > 5.0:
		var direction = to_target.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		position = target_position  # Snap to final position
		
	# Targeting
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
			look_at(nearest.global_position)
		$AnimationPlayer.stop()
	else:
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("Attack")
		
	
	move_and_slide()

	
func _on_hurtbox_area_entered(area: Area2D) -> void:
	health -= 1
	if health < 1:
		queue_free()
