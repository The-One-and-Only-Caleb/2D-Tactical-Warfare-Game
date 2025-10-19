extends Line2D

var control_points = []

var troops_count = 0

@export var troop: PackedScene
@export var total_troops: int


func _ready():
	control_points = [$ControlPoint, $ControlPoint2]
	# Initialize the line with the correct number of points
	
	$ControlPoint.position = points[0]
	$ControlPoint2.position = points[1]
	
	spawn_troops()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_point_position(0, $ControlPoint.position)
	set_point_position(1, $ControlPoint2.position)
		
func spawn_troops():
	for i in range(0, total_troops):
		var new_troop = troop.instantiate()
		var start_point = to_global(points[0])
		var end_point = to_global(points[1])
	# Calculate how far along the segment this troop should be placed
		var placement_ratio = 0.0
		if total_troops > 1:
			placement_ratio = float(troops_count) / (total_troops - 1)

	# Use linear interpolation to find the exact position
		var spawn_pos = start_point.lerp(end_point, placement_ratio)
		new_troop.init(troops_count, total_troops, spawn_pos, get_point_position(0), get_point_position(1))  # Pass index and total count
		add_child(new_troop)
		troops_count += 1
		
