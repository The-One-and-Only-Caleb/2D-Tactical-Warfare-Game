extends Node2D

@onready var orc = load("res://Enemies/orc.tscn")


func _on_timer_timeout() -> void:
	var new_orc = orc.instantiate()
	new_orc.global_position = global_position
	new_orc.rotation = rotation
	add_child(new_orc)
