extends Node2D

signal line_drawn(points: Array)

var is_drawing := false
var points := []

var point2_confirmed = false

func _ready() -> void:
	start_drawing()


func start_drawing():
	is_drawing = true
	points.clear()
	$Line2D.clear_points()
	
func _process(delta: float) -> void:
	if is_drawing and points.size() == 1 and !point2_confirmed:
		var pos = get_viewport().get_mouse_position()
		$Line2D.set_point_position(1, pos)


func _input(event):
	if not is_drawing:
		return

	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			if !point2_confirmed:
				if points.size() == 0:
					var global_pos = get_viewport().get_mouse_position()
					points.append(global_pos)
					$Line2D.add_point(global_pos)
					print($Line2D.points)
					
					$Line2D.add_point(global_pos) # Add point 2 to be set later

					print("point added at: " + str(global_pos))
				else:
					var global_pos = get_viewport().get_mouse_position()
					$Line2D.set_point_position(1, global_pos)
					points.append(global_pos)
					point2_confirmed = true

			if points.size() >= 2 and point2_confirmed:
				finish_drawing()

		elif event.is_action_pressed("right_click"):
			cancel_drawing()

func finish_drawing():
	is_drawing = false
	emit_signal("line_drawn", points)
	
	var new_line = load("res://Lines/warrior_line_scene.tscn").instantiate()
	new_line.clear_points()
	new_line.add_point(Vector2.ZERO)  # placeholder
	new_line.add_point(Vector2.ZERO)
	new_line.set_point_position(0, points[0])
	new_line.set_point_position(1, points[1])
	get_tree().current_scene.add_child(new_line)
	print("New Line points: " + str(new_line.points))
	print("Old line points: " + str(points))
	#queue_free()

func cancel_drawing():
	is_drawing = false
	points.clear()
	$Line2D.clear_points()
	queue_free()
