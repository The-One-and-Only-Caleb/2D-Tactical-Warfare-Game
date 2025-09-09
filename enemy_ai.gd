extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	var overlapping = $General.get_overlapping_areas()
	if overlapping.size() > 0:
		print("Player is attacking the general!, Go defensive")
	else:
		print("going offensive!")
