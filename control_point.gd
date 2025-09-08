extends Area2D

var mouse_on = false
var dragging = false
var line_dragging = false

func _physics_process(delta: float) -> void:
	
	if dragging == true:
		global_position = get_viewport().get_mouse_position()

	if mouse_on == true and Input.is_action_pressed("left_click") == true:
		dragging = true
	
	if Input.is_action_pressed("left_click") == false:
		dragging = false
		
	if Input.is_action_pressed("right_click") == true and mouse_on == true:
		line_dragging = true
		
	if Input.is_action_pressed("right_click") == false:
		line_dragging = false
	
	if line_dragging == true:
		get_parent().global_position = get_viewport().get_mouse_position()

func _on_mouse_entered() -> void:
	mouse_on = true
	

func _on_mouse_exited() -> void:
	mouse_on = false
