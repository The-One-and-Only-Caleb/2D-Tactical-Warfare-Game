extends Node2D


var shoot_ready = true

@onready var red_bullet = preload("res://Bullets/red_bullet.tscn")
@onready var blue_bullet = preload("res://Bullets/blue_bullet.tscn")
@onready var green_bullet = preload("res://Bullets/green_bullet.tscn")
@onready var purple_bullet = preload("res://Bullets/purple_bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameScript.gun_index = GameScript.gun_types.find(GameScript.gun)


# Handle scroll wheel input to change gun
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			GameScript.gun_index = (GameScript.gun_index + 1) % GameScript.gun_types.size()
			GameScript.gun = GameScript.gun_types[GameScript.gun_index]
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			GameScript.gun_index = (GameScript.gun_index - 1 + GameScript.gun_types.size()) % GameScript.gun_types.size()
			GameScript.gun = GameScript.gun_types[GameScript.gun_index]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if GameScript.paused == false:
		var mouse_pos = get_global_mouse_position()
		look_at(mouse_pos)
		
		if Input.is_action_pressed("shoot") and shoot_ready == true:
			var bullet_scene = null
			if GameScript.gun == "red":
				bullet_scene = red_bullet
			elif GameScript.gun == "blue":
				bullet_scene = blue_bullet
			elif GameScript.gun == "purple":
				bullet_scene = purple_bullet
			elif GameScript.gun == "green":
				bullet_scene = green_bullet
			if bullet_scene:
				var new_bullet = bullet_scene.instantiate()
				new_bullet.global_position = $Finger_Gun/Barrel.global_position
				new_bullet.global_rotation = $Finger_Gun/Barrel.global_rotation
				get_tree().current_scene.add_child(new_bullet)
				shoot_ready = false
				$Shoot_Timer.start()
				# Add new_bullet to the scene tree, set its position/rotation as needed

		# Normalize rotation_degrees to (-180, 180]
		var normalized_rotation = fposmod(rotation_degrees + 180, 360) - 180
		# Debug: print the normalized rotation
		# Flip the gun sprite vertically when facing left
		if normalized_rotation > 90 or normalized_rotation < -90:
			if !$Finger_Gun.flip_v:
				$Finger_Gun.flip_v = true
		else:
			if $Finger_Gun.flip_v:
				$Finger_Gun.flip_v = false


func _on_shoot_timer_timeout() -> void:
	shoot_ready = true
