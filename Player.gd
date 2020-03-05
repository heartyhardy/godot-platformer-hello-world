extends KinematicBody2D

const SPEED = 60
const GRAVITY = 10
const JUMP_FORCE = -250

const FLOOR = Vector2(0,-1)

var velocity = Vector2()
var is_on_ground =false

func _physics_process(delta):	
#	X axis movement (MOVE)
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x=-SPEED
	else:
		velocity.x=0
		
		
#	Y axis movement (JUMP)
	if Input.is_action_pressed("ui_up") and is_on_ground:
		velocity.y = JUMP_FORCE
	
#	Grvity increasing per frame
	velocity.y += GRAVITY
	
	if is_on_floor():
		is_on_ground=true
	else:
		is_on_ground=false
	
#	By setting velocity to return value of move and slide...
#	it retains it's position after a jump or falling down
#	Floor is the top of the tile
	velocity = move_and_slide(velocity,FLOOR)
