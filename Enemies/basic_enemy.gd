extends CharacterBody2D


@export var speed := 300.0
@export var health = 4
var color_type := "none"

func _ready() -> void:
	# 40% none, 15% each color
	var r = randf()
	if r < 0.4:
		color_type = "none"
	elif r < 0.55:
		color_type = "red"
	elif r < 0.7:
		color_type = "blue"
	elif r < 0.85:
		color_type = "green"
	else:
		color_type = "purple"

	var mask = 2 # default normal (layer 2)
	var color = Color(1,1,1) # default white
	if color_type == "red":
		mask = 4    # layer 3
		$Hurtbox.collision_mask |= 128
		color = Color(1,0.2,0.2)
	elif color_type == "blue":
		mask = 8    # layer 4
		$Hurtbox.collision_mask |= 128
		color = Color(0.3,0.5,0.8)
	elif color_type == "green":
		mask = 16   # layer 5
		$Hurtbox.collision_mask |= 128
		color = Color(0.3,1,0.3)
	elif color_type == "purple":
		mask = 32   # layer 6
		$Hurtbox.collision_mask |= 128
		color = Color(0.7,0.3,1)
	$Hurtbox.collision_mask |= mask
	$Sprite2D.self_modulate = color

func _physics_process(_delta: float) -> void:
	if GameScript.paused == false:
		if not bounce_timer_active:
			var direction = (GameScript.player_pos - global_position).normalized()
			velocity = direction * speed
		
		if health < 1:
			queue_free()
		
		move_and_slide()

# --- Bounce logic ---
var bounce_timer := 0.0
var bounce_timer_active := false
const BOUNCE_DURATION := 0.2
const BOUNCE_SPEED := 400

	


func _process(delta):
	if bounce_timer_active:
		bounce_timer -= delta
		if bounce_timer <= 0.0:
			bounce_timer_active = false

	# Bounce off player if overlapping
	if not bounce_timer_active:
		var hitbox = $Hitbox if has_node("Hitbox") else null
		if hitbox:
			for body in hitbox.get_overlapping_bodies():
				if body.is_in_group("Player"):
					var away = (global_position - body.global_position).normalized()
					velocity = away * BOUNCE_SPEED
					bounce_timer = BOUNCE_DURATION
					bounce_timer_active = true
					break
	



func _on_hurtbox_area_entered(area: Node2D) -> void:
	if area.get_collision_layer() != 128:
		health -= 2
		var layer = area.get_collision_layer()
		if layer == 7:
			GameScript.red_bullet_exp += 1
		elif layer == 11:
			GameScript.blue_bullet_exp += 1
		elif layer == 19:
			GameScript.green_bullet_exp += 1
		elif layer == 35:
			GameScript.purple_bullet_exp += 1
	elif area.get_collision_layer() == 128:
		color_type = "purple"		
		$Sprite2D.self_modulate = Color(0.7,0.3,1)
		$Hurtbox.collision_mask = 32
		$Hurtbox.collision_mask |= 128
		


func _on_hitbox_body_entered(body: Node2D) -> void:
	var away = (global_position - body.global_position).normalized()
	velocity = away * BOUNCE_SPEED
	bounce_timer = BOUNCE_DURATION
	bounce_timer_active = true
