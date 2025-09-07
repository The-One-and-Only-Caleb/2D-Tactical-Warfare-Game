extends Area2D

var mouse_on = false
var dragging = false

func _physics_process(delta: float) -> void:
	
	if dragging == true:
		global_position = get_viewport().get_mouse_position()

	if mouse_on == true and Input.is_action_pressed("left_click") == true:
		dragging = true
	
	if Input.is_action_pressed("left_click") == false:
		dragging = false
		

func _on_mouse_entered() -> void:
	mouse_on = true
	

func _on_mouse_exited() -> void:
	mouse_on = false
