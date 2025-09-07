extends Node

var gun = "red"
var gun_types = ["red", "blue", "green", "purple"]
var gun_index = 0

var player_pos
var player_health = 10

var red_bullet_exp = 0
var blue_bullet_exp = 0
var green_bullet_exp = 0
var purple_bullet_exp = 0

var red_bullet_level = 1
var blue_bullet_level = 1
var green_bullet_level = 1
var purple_bullet_level = 1

var red_bullet_upgrades = {}
var blue_bullet_upgrades = {}
var green_bullet_upgrades = {}
var purple_bullet_upgrades = {}

var leveling_up = false
var paused = false
var bullet_leveled = ""

var paint_infusion = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if red_bullet_exp > red_bullet_level^2 + 9:
		print("red bullet leveled up")
		red_bullet_level += 1
		red_bullet_exp = 0
		paused = true
		leveling_up = true
		bullet_leveled = "red"
	if blue_bullet_exp > blue_bullet_level^2 + 9:
		print("blue bullet leveled up")
		blue_bullet_level += 1
		blue_bullet_exp = 0
		paused = true
		leveling_up = true
		bullet_leveled = "blue"
	if green_bullet_exp > green_bullet_level^2 + 9:
		print("green bullet leveled up")
		green_bullet_level += 1
		green_bullet_exp = 0
		paused = true
		leveling_up = true
		bullet_leveled = "green"
	if purple_bullet_exp > purple_bullet_level^2 + 9:
		print("purple bullet leveled up")
		purple_bullet_level += 1
		purple_bullet_exp = 0
		paused = true
		leveling_up = true
		bullet_leveled = "purple"
