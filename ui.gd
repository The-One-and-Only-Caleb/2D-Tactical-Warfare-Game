extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameScript.gun == "red":
		$MeshInstance2D/BulletRed.visible = true
	else:
		$MeshInstance2D/BulletRed.visible = false
		
	if GameScript.gun == "blue":
		$MeshInstance2D/BulletBlue.visible = true
	else:
		$MeshInstance2D/BulletBlue.visible = false
		
	if GameScript.gun == "green":
		$MeshInstance2D/BulletGreen.visible = true
	else:
		$MeshInstance2D/BulletGreen.visible = false
		
	if GameScript.gun == "purple":
		$MeshInstance2D/BulletPurple.visible = true
	else:
		$MeshInstance2D/BulletPurple.visible = false
	
	if GameScript.leveling_up == true:
		$Leveling_up_screen.visible = true
		# Red bullet level ups
		if GameScript.bullet_leveled == "red":
			pass
		# Blue bullet level ups
		if GameScript.bullet_leveled == "blue":
			pass
		# Green bullet level ups
		if GameScript.bullet_leveled == "green":
			pass
		# Purple bullet level ups
		if GameScript.bullet_leveled == "purple":
			if GameScript.purple_bullet_level == 2:
				$Leveling_up_screen/Upgrade1.text = "Splash nearby enemies with a colour: Purple"
				$Leveling_up_screen/Upgrade2.text = "Make your next bullet additionally hit enemies with a colour: Purple"
				$Leveling_up_screen/Upgrade3.text = "Do +25% more damage against enemies of a colour: Purple"
	else:
		$Leveling_up_screen.visible = false
	


func _on_upgrade_1_pressed() -> void:
	if GameScript.bullet_leveled == "purple":
			if GameScript.purple_bullet_level == 2:
				GameScript.purple_bullet_upgrades["Paint Splash"] = {"level": 1, "colour": "purple"}
				GameScript.leveling_up = false
				GameScript.paused = false
