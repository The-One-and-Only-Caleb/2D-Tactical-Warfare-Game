extends Node2D

var control_points = []

var troops_assigned = 0

func _ready():
	var line = $Line2D
	line.points = [Vector2(100, 200), Vector2(100, 300)]
	control_points = [$ControlPoint, $ControlPoint2]
	# Initialize the line with the correct number of points
	var initial_points := []
	for cp in control_points:
		initial_points.append(cp.global_position)
	$Line2D.points = initial_points
	
	var troop = preload("res://warrior.tscn").instantiate()
	troop.init(1, 2, $Line2D.get_point_position(0), $Line2D.get_point_position(1))  # Pass index and total count
	add_child(troop)
	troop.global_position = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in control_points.size():
		$Line2D.set_point_position(i, control_points[i].global_position)
		
	
