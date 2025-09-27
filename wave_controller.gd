extends Area2D

class_name Wave_Controller

@export var waves: Array[WaveData] = []

var current_wave_index := 0
var active_timers: Array = []
var wave_in_progress := false

func _ready():
	start_wave(0)
	print("wave started")
	
func _process(delta: float) -> void:
	if wave_in_progress == false and current_wave_index < waves.size():
		current_wave_index += 1
		start_wave(current_wave_index)
		wave_in_progress = true
	#elif wave_in_progress == false and current_wave_index > waves.size() - 1:
		#print("level finished")
		#GameScript.level_finished = true

func start_wave(index: int):
	wave_in_progress = true
	print(index)
	print(waves.size())
	if index >= waves.size():
		print("Invalid wave index")
		return

	var wave = waves[index]
	
	var wave_timer = Timer.new()
	wave_timer.wait_time = waves[current_wave_index].duration
	wave_timer.autostart = true
	wave_timer.one_shot = true
	add_child(wave_timer)
	wave_timer.connect("timeout", Callable(self, "on_wave_timer_timeout").bind(wave_timer))

	for group in wave.enemies:
		print("creating timer")
		group.spawned = 0  # reset count

		var interval = wave.duration / group.count
		var timer = Timer.new()
		timer.wait_time = interval
		timer.one_shot = false
		timer.autostart = true
		add_child(timer)
		active_timers.append(timer)
		print("Timer created for group with count:", group.count)

		# Capture group reference for this timer
		timer.connect("timeout", Callable(self, "_on_enemy_timer_timeout").bind(group, timer))

func _on_enemy_timer_timeout(group: EnemySpawnData, timer: Timer):
	group.spawned += 1
	if group.spawned >= group.count:
		timer.stop()
		timer.queue_free()
		active_timers.erase(timer)
	print("Timer fired for group:", group)


	var enemy = group.enemy_scene.instantiate()
	add_child(enemy)
	enemy.global_position = get_random_position_in_area()
	#enemy.global_position = Vector2(500, 500)

	group.spawned += 1
	print("Spawned enemy")

func on_wave_timer_timeout(wave_timer: Timer):
	wave_in_progress = false
	
	current_wave_index += 1
	if current_wave_index < waves.size():
		start_wave(current_wave_index)
	else:
		print("All waves completed")
		GameScript.level_finished = true


			
			
func get_random_position_in_area() -> Vector2:
	var shape = $CollisionShape2D.shape
	if shape is RectangleShape2D:
		var extents = shape.extents
		var local_pos = Vector2(
			randf_range(-extents.x, extents.x),
			randf_range(-extents.y, extents.y)
		)
		return global_position + local_pos.rotated(rotation)
	return global_position
