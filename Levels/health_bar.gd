extends Node2D

func _process(delta: float) -> void:
	$ProgressBar.value = GameScript.health
