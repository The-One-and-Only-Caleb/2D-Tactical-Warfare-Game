extends Line2D

var control_points = []

var troops_count = 0

var troop_assigned = 8

func _ready():
	points = [Vector2(100, 200), Vector2(100, 300)]
	control_points = [$ControlPoint, $ControlPoint2]
	# Initialize the line with the correct number of points
	var initial_points := []
	for cp in control_points:
		initial_points.append(cp.global_position)
	points = initial_points
	
	spawn_troops()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_point_position(0, $ControlPoint.position)
	set_point_position(1, $ControlPoint2.position)
		
func spawn_troops():
	for i in range(0, troop_assigned):
		var troop = preload("res://warrior.tscn").instantiate()
		troop.init(troops_count, troop_assigned, get_point_position(0), get_point_position(1))  # Pass index and total count
		add_child(troop)
		troops_count += 1
		
