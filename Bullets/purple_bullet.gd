extends CharacterBody2D

var destroyed = 0
const SPEED = 800.0



func _ready() -> void:
	$Hurtbox.body_entered.connect(_on_hurtbox_body_entered)

func _on_hurtbox_body_entered(_body):
	if GameScript.purple_bullet_upgrades.has("Paint Splash") == true:
		$AreaofAffect/CollisionShape2D.call_deferred("set_disabled", false)
	destroyed += 1

func _physics_process(delta: float) -> void:
	if GameScript.paused == false:
		velocity = Vector2.RIGHT.rotated(rotation) * SPEED
		position += velocity * delta
		move_and_slide()
	if destroyed > 0:
		destroyed += 1
	if destroyed > 2:	
		queue_free()
