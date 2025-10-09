extends Node2D

@onready var bg_music_slider: HSlider = $BGVolumeSlider
@onready var sfx_slider: HSlider = $SFXVolumeSlider

const MUSIC_BUS := "Music"
const SFX_BUS := "SFX"

@onready var music_bus_index := AudioServer.get_bus_index(MUSIC_BUS)
@onready var sfx_bus_index := AudioServer.get_bus_index(SFX_BUS)

func _ready():
	# Initialize sliders to current bus volumes
	bg_music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_index))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_index))


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://home_screen.tscn")


func _on_bg_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(value))


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(value))
