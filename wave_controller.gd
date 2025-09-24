extends Area2D

class_name Wave_Controller

@export var waves: Array[WaveData] = []

var current_wave_index := 0
var active_timers: Array = []
var wave_in_progress := false

func _ready():
	start_wave(0)
	print("wave started")

func start_wave(index: int):
	if index >= waves.size():
		print("Invalid wave index")
		return

	var wave = waves[index]
	clear_active_timers()

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

		# Capture group reference for this timer
		timer.connect("timeout", Callable(self, "_on_enemy_timer_timeout").bind(group, timer))

func _on_enemy_timer_timeout(group: EnemySpawnData, timer: Timer):
	if group.spawned >= group.count:
		timer.stop()
		timer.queue_free()
		active_timers.erase(timer)

		# Check if all timers are done
		if active_timers.is_empty() and wave_in_progress:
			wave_in_progress = false
			print("Wave", current_wave_index, "complete!")
			start_wave(current_wave_index + 1)
		return

	var enemy = group.enemy_scene.instantiate()
	add_child(enemy)
	enemy.global_position = get_random_position_in_area()
	#enemy.global_position = Vector2(500, 500)

	group.spawned += 1
	print("Spawned enemy")


func clear_active_timers():
	for timer in active_timers:
		timer.stop()
		timer.queue_free()
	active_timers.clear()

			
			
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
