extends Node2D


func _process(delta: float) -> void:
	$CanvasLayer/Panel/MarginContainer/GridContainer/TextureRect/MoneyLabel.text = str(GameScript.money)

func _on_soldierbuy_pressed() -> void:
	if GameScript.money >= 10:
		var line_drawer = load("res://Lines/line_drawer.tscn").instantiate()
		line_drawer.line_scene = load("res://Lines/warrior_line_scene.tscn")
		get_tree().current_scene.add_child(line_drawer)
		GameScript.money -= 10
	else:
		print("out of money")
		



func _on_hammer_kbuy_pressed() -> void:
	if GameScript.money >= 15:
		var line_drawer = load("res://Lines/line_drawer.tscn").instantiate()
		line_drawer.line_scene = load("res://Lines/hammer_knight_line_scene.tscn")
		get_tree().current_scene.add_child(line_drawer)
		GameScript.money -= 15
	else:
		print("out of money")


func _on_arrow_cbuy_pressed() -> void:
	if GameScript.money >= 20:
		var line_drawer = load("res://Lines/line_drawer.tscn").instantiate()
		line_drawer.line_scene = load("res://Lines/arrow_caster_line_scene.tscn")
		get_tree().current_scene.add_child(line_drawer)
		GameScript.money -= 20
	else:
		print("out of money")
