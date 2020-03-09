extends Area2D

const SPEED = 100
var velocity = Vector2()
var direction = 1

func _ready():
	pass # Replace with function body.
	
func set_fireball_direction(dir):
	direction = dir
	if direction == -1:
		$Fireball_Ani.flip_h = true
	else:
		$Fireball_Ani.flip_h = false
		
func _physics_process(delta):
	velocity.x = SPEED * direction * delta
	$Fireball_Ani.play("Shoot")
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	

func _on_Fireball_Emp_body_entered(body):
	if "Soldier" in body.name:
		body.die(2)
	queue_free()
