extends KinematicBody2D

const GRAVITY = 10
const FLOOR = Vector2(0, -1)

export(int) var speed = 30
export(int) var hp = 1
export(Vector2) var size = Vector2(1,1)
export(Color) var color = Color(1,1,1)

var velocity = Vector2()
var direction = 1
var is_alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = size
	modulate = color
	pass

func _physics_process(_delta):
	if is_alive:
		velocity.x = speed * direction
		
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
		
	if get_slide_count() > 0:
		for i in (get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.die()
		
func die(damage):
	hp -= damage
	if hp <= 0:
		is_alive=false
		$CollisionShape2D.set_deferred("disabled", true)
		velocity = Vector2(0,0)
		$Soldier_Ani.play("Dead")
		$Timer.start()
		if size > Vector2(1,1):
			get_parent().get_node("ScreenShake").screen_shake(1,10,100)


func _on_Timer_timeout():
	queue_free()
