extends Node

var health = 5
var level_finished = false
var current_level = 1

var level_paths = [
	"res://Levels/level_1.tscn",
	"res://Levels/level_2.tscn",
	# Add more as needed
]


func _process(delta: float) -> void:
	if health < 1:
		get_tree().change_scene_to_file("res://game_over.tscn")
	
	if level_finished == true:
		if current_level < level_paths.size():
			get_tree().change_scene_to_file(level_paths[current_level])
			current_level += 1
			level_finished = false
		
		else:
			level_finished = false
			get_tree().change_scene_to_file("res://win.tscn")
			print("Changing to win screen")
		
	
	
	
	
