extends CharacterBody2D

@export var speed = 300

var destroying = false


func _physics_process(delta: float) -> void:
	
	var collision = move_and_collide(Vector2.RIGHT.rotated(rotation) * speed * delta)
	
	if destroying == true:
		queue_free()
	
	if collision:
		if collision.get_collider() is PhysicsBody2D or collision.get_collider() is Area2D:
			if collision.get_collider().collision_layer & (1 << 4):
				return
			destroying = true
		else:
			destroying = true
		
	
	
