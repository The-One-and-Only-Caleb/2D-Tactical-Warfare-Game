extends CharacterBody2D

var speed := 400.0




func _on_hurtbox_area_entered(_area):
	GameScript.player_health -= 1
	if GameScript.player_health < 1:
		queue_free()


func _physics_process(delta: float) -> void:
	if GameScript.paused == false:
		var input_vector = Vector2.ZERO
		input_vector.y -= int(Input.is_action_pressed("move_up"))
		input_vector.y += int(Input.is_action_pressed("move_down"))
		input_vector.x -= int(Input.is_action_pressed("move_left"))
		input_vector.x += int(Input.is_action_pressed("move_right"))

		if input_vector.length() > 0:
			input_vector = input_vector.normalized()
			velocity = input_vector * speed
			# Animation and flipping
			var anim_sprite = $AnimatedSprite2D
			if abs(input_vector.x) > abs(input_vector.y):
				anim_sprite.animation = "walk_sideways"
				anim_sprite.flip_h = input_vector.x < 0
			elif input_vector.y < 0:
				anim_sprite.animation = "walk_backwards"
				anim_sprite.flip_h = false
			else:
				anim_sprite.animation = "walk_forwards"
				anim_sprite.flip_h = false
			if !anim_sprite.is_playing():
				anim_sprite.play()
		else:
			velocity = Vector2.ZERO
			$AnimatedSprite2D.play("idle")

		GameScript.player_pos = position
		$HealthBar.value = GameScript.player_health

		# Animate health bar background color (HSV cycling)
		var t = Time.get_ticks_msec() / 1000.0
		var color = Color.from_hsv(fmod(t * 0.2, 1.0), 0.8, 1.0)
		var stylebox = $HealthBar.get("theme_override_styles/background")
		if stylebox:
			stylebox.bg_color = color

		# Ensure player and health bar render in front
		z_index = 100
		$HealthBar.z_index = 101

		move_and_slide()
