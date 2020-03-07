extends KinematicBody2D

const SPEED = 30
const GRAVITY = 10
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = 1
var is_alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if is_alive:
		velocity.x = SPEED * direction
		
		if direction == -1:
			$Soldier_Ani.flip_h=true
		else:
			$Soldier_Ani.flip_h=false
				
		$Soldier_Ani.play("Walk")
		
		velocity.y += GRAVITY
		
		velocity = move_and_slide(velocity, FLOOR)
	
	#if bang into a wall, turn around
	if is_on_wall():
		direction *= -1
		$RayCast2D.position.x *= -1
	
	#if at the end of a ledge, turn around
	if !$RayCast2D.is_colliding():
		direction *= -1
		$RayCast2D.position.x *= -1
		
func die():
	is_alive=false
	$CollisionShape2D.set_deferred("disabled", true)
	velocity = Vector2(0,0)
	$Soldier_Ani.play("Dead")
	$Timer.start()


func _on_Timer_timeout():
	queue_free()
