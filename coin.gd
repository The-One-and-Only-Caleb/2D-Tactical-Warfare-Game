extends Node2D


func _process(delta: float) -> void:
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("Spin")


	
func coin_picked_up():
	GameScript.money += 1
	$AnimationPlayer.play("Pick_Up")

func delete_coin():
	queue_free()


func _on_pickup_box_body_entered(body: Node2D) -> void:
	coin_picked_up()
