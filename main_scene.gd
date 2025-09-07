extends Node2D

var control_points = []

func _ready():
	var line = $Line2D
	line.points = [Vector2(100, 200), Vector2(100, 300), Vector2(100, 400)]
	control_points = [$ControlPoint, $ControlPoint2, $ControlPoint3, $ControlPoint4]
	# Initialize the line with the correct number of points
	var initial_points := []
	for cp in control_points:
		initial_points.append(cp.global_position)
	$Line2D.points = initial_points


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in control_points.size():
		$Line2D.set_point_position(i, control_points[i].global_position)
