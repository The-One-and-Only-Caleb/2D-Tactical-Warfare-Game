extends Node2D


@onready var camera := $Camera2D

var dragging := false
var drag_start := Vector2.ZERO
var camera_start := Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed and Input.is_action_pressed("right_click"):
				dragging = true
				drag_start = event.position
				camera_start = camera.position
			elif not event.pressed:
				dragging = false

	elif event is InputEventMouseMotion and dragging:
		var offset = drag_start - event.position
		camera.position = camera_start + offset
