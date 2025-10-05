extends Area2D

var mouse_on = false
var dragging = false
var line_dragging = false
var drag_start_mouse_pos
var drag_start_line_pos
var drag_offset := Vector2.ZERO


func _physics_process(delta: float) -> void:
	
	if dragging == true:
		global_position = get_global_mouse_position()

	if mouse_on == true and Input.is_action_pressed("left_click") == true:
		dragging = true
	
	if Input.is_action_pressed("left_click") == false:
		dragging = false
		
	#if Input.is_action_pressed("right_click") == true and mouse_on == true:
		#line_dragging = true
		
	#if Input.is_action_pressed("right_click") == false:
		#line_dragging = false
		#drag_start_mouse_pos = get_global_mouse_position()
		#drag_start_line_pos = get_parent().global_position
	
	#if line_dragging == true:
		#var target_global_pos = get_global_mouse_position() + drag_offset
		#var line = get_parent()
		#var line_offset = target_global_pos - global_position

		# Move the line only
		#line.global_position += line_offset
		# Do NOT move control points—they're children and will follow





func _on_mouse_entered() -> void:
	mouse_on = true
	

func _on_mouse_exited() -> void:
	mouse_on = false
