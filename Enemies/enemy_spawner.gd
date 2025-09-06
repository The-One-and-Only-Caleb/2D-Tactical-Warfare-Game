extends Node2D

@export var spawn_radius := 800.0
@export var spawn_interval := 2.0
@export var enemy_scene := load("res://Enemies/basic_enemy.tscn")

func _ready():
	$Timer.wait_time = spawn_interval
	$Timer.start()



func _on_timer_timeout() -> void:
	if GameScript.paused == false:
		var player_pos = GameScript.player_pos
		var angle = randf() * TAU
		var distance = spawn_radius + randf() * 200.0 # 200 is extra randomization
		var spawn_pos = player_pos + Vector2(cos(angle), sin(angle)) * distance
		var enemy = enemy_scene.instantiate()
		enemy.global_position = spawn_pos
		get_tree().current_scene.add_child(enemy)
