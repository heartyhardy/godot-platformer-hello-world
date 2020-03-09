extends Area2D

const SPEED = 100

var velocity = Vector2()

#Direction of the Fireball
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#set the direction of the Fireball facing
func set_fireball_direction(dir):
	direction = dir
	if direction == -1:
		$Fireball_Ani.flip_h=true
	else:
		$Fireball_Ani.flip_h=false
		

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	$Fireball_Ani.play("Shoot")
	translate(velocity)

#Fire this even when Fireball moves out of screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

#Fire this even when Fireball collision body collides with another
func _on_Fireball_body_entered(body):
	if "Soldier" in body.name:
		body.die(1)
	queue_free()
