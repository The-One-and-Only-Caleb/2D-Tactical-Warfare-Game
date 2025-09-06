extends CharacterBody2D


const SPEED = 800.0



func _ready() -> void:
	$Hurtbox.body_entered.connect(_on_hurtbox_body_entered)

func _on_hurtbox_body_entered(_body):
	$"Area of Affect/CollisionShape2D".disabled = false
	queue_free()

func _physics_process(delta: float) -> void:
	if GameScript.paused == false:
		velocity = Vector2.RIGHT.rotated(rotation) * SPEED
		position += velocity * delta
		move_and_slide()
