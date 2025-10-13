extends Line2D

var control_points = []

var troops_count = 0

@export var troop: PackedScene
@export var total_troops: int


func _ready():
	points = [Vector2(100, 200), Vector2(100, 300)]
	control_points = [$ControlPoint, $ControlPoint2]
	# Initialize the line with the correct number of points
	var initial_points := []
	for cp in control_points:
		initial_points.append(cp.global_position)
	points = initial_points
	print("function ready called")
	print(points)
	
	$ControlPoint.global_position = points[0]
	$ControlPoint2.global_position = points[1]
	
	spawn_troops()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("points overwritten")
	set_point_position(0, $ControlPoint.position)
	set_point_position(1, $ControlPoint2.position)
	print(points)
		
func spawn_troops():
	for i in range(0, total_troops):
		var new_troop = troop.instantiate()
		new_troop.init(troops_count, total_troops, get_point_position(0), get_point_position(1))  # Pass index and total count
		add_child(new_troop)
		new_troop.global_position = global_position
		troops_count += 1
		
