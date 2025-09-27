extends Node

var health = 5
var level_finished = false
var current_level = 1

func _process(delta: float) -> void:
	if health < 1:
		get_tree().change_scene_to_file("res://game_over.tscn")
	
	if level_finished == true:
		current_level += 1
		var next_level = "res://Levels/level_" + str(current_level) + ".tscn"
		if FileAccess.file_exists(next_level):
			level_finished = false
			get_tree().change_scene_to_file(next_level)
			print("Changing to Level " + str(current_level))
		else:
			level_finished = true
			get_tree().change_scene_to_file("res://win.tscn")
			print("Changing to win screen")
		
	
	
	
	
