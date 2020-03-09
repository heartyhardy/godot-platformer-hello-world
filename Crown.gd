extends Area2D

func _ready():
	$AnimatedSprite.play("PowerUp")


func _on_Crown_body_entered(body):
	if "Player" in body.name:
		body.crown_power_up()
		queue_free()
