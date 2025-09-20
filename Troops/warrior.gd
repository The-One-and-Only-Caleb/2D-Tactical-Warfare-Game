extends CharacterBody2D


const speed = 400.0

var troop_number
var total_troop_count

var start_point
var end_point
@export var health = 5

var nav_agent: NavigationAgent2D


func init(number, count, start, end) -> void:
	troop_number = number
	total_troop_count = count
	start_point = start
	end_point = end
	
func _ready() -> void:
	nav_agent = get_node_or_null("NavigationAgent2D")
	if nav_agent != null:
		update_nav()
	else:
		push_error("NavigationAgent2D not found in _ready()")
	

func _physics_process(_delta: float) -> void:
	# Movement
	if nav_agent.distance_to_target():
		var distance = nav_agent.distance_to_target()
		if distance > 5.0:
			var direction = nav_agent.get_next_path_position().normalized()
			velocity = direction * speed
		else:
			velocity = Vector2.ZERO
			position = nav_agent.target_position  # Snap to final position
			
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


func update_nav():
	var start_point = get_parent().get_point_position(0)
	var end_point = get_parent().get_point_position(1)
	# Calculate how far along the segment this troop should be placed
	var placement_ratio = 1 - float(troop_number) / (total_troop_count - 1)
	# Use linear interpolation to find the exact position
	nav_agent.target_position = start_point.lerp(end_point, placement_ratio)

func _on_navtimer_timeout() -> void:
	update_nav()
