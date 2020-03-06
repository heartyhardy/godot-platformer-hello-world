extends KinematicBody2D

const FIREBALL = preload("res://Fireball.tscn")

const SPEED = 60
const GRAVITY = 10
const JUMP_FORCE = -250

const FLOOR = Vector2(0,-1)

var velocity = Vector2()
var is_on_ground =false

func _physics_process(_delta):	
#	X axis movement (MOVE)
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Player_Anim.flip_h=false		
		$Player_Anim.play("Run")
		if sign($ShootPos.position.x) == -1:
			$ShootPos.position.x *= -1
	elif Input.is_action_pressed("ui_left"):
		velocity.x=-SPEED
		$Player_Anim.flip_h=true
		$Player_Anim.play("Run")
		if sign($ShootPos.position.x) == 1:
			$ShootPos.position.x *= -1		
	else:
		velocity.x=0
		if is_on_ground:
			$Player_Anim.play("Idle")
		
		
#	Y axis movement (JUMP)
	if Input.is_action_pressed("ui_up") and is_on_ground:
		velocity.y = JUMP_FORCE
		
#	Shoot Fireballs
	if Input.is_action_just_pressed("ui_select"):
		var fireball = FIREBALL.instance()
		if sign($ShootPos.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		get_parent().add_child(fireball)
		fireball.position = $ShootPos.global_position
#	Grvity increasing per frame
	velocity.y += GRAVITY
	
	if is_on_floor():
		is_on_ground=true
	else:
		is_on_ground=false
		if velocity.y < 0:
			$Player_Anim.play("Jump")
		else:
			$Player_Anim.play("Fall")
	
#	By setting velocity to return value of move and slide...
#	it retains it's position after a jump or falling down
#	Floor is the top of the tile
	velocity = move_and_slide(velocity,FLOOR)
