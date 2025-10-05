class_name HitBox

extends Area2D

@export var damage := 2

@export var knockback := 0


func _init() -> void:
	collision_layer = 2
	collision_mask = 0
