extends Node2D


func _process(delta: float) -> void:
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("Spin")


	
func coin_picked_up():
	GameScript.money += 1
	$AnimationPlayer.play("Pick_Up")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Pick_Up":
		queue_free()


func _on_pickup_box_body_entered(body: Node2D) -> void:
	coin_picked_up()
