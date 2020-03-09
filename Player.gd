extends KinematicBody2D

const FIREBALL = preload("res://Fireball.tscn")
const FIREBALL_EMP = preload("res://Fireball_Emp.tscn")

const SPEED = 60
const GRAVITY = 10
const JUMP_FORCE = -250

const FLOOR = Vector2(0,-1)

var fireball_power = 1

var velocity = Vector2()
var is_on_ground =false
var is_attacking=false
var is_dead = false

func _physics_process(_delta):	
	if !is_dead:
	#	X axis movement (MOVE)
		if Input.is_action_pressed("ui_right"):
			if !is_attacking || !is_on_floor():
				velocity.x = SPEED
				if !is_attacking:
					$Player_Anim.flip_h=false		
					$Player_Anim.play("Run")
					if sign($ShootPos.position.x) == -1:
						$ShootPos.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			if !is_attacking || !is_on_floor():
				velocity.x=-SPEED
				if !is_attacking:
					$Player_Anim.flip_h=true
					$Player_Anim.play("Run")
					if sign($ShootPos.position.x) == 1:
						$ShootPos.position.x *= -1		
		else:
			velocity.x=0
			if is_on_ground && !is_attacking:
				$Player_Anim.play("Idle")
			
			
	#	Y axis movement (JUMP)
		if Input.is_action_pressed("ui_up") and is_on_ground:
			if !is_attacking:
				velocity.y = JUMP_FORCE
			
	#	Shoot Fireballs
		if Input.is_action_just_pressed("ui_select") && !is_attacking:
			if is_on_floor():
				velocity.x=0
			is_attacking=true
			$Player_Anim.play("Attack")
			var fireball
			if fireball_power == 1:
				fireball = FIREBALL.instance()
			elif fireball_power == 2:
				fireball = FIREBALL_EMP.instance()
			if sign($ShootPos.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $ShootPos.global_position
			
	#	Grvity increasing per frame
		velocity.y += GRAVITY
		
		if is_on_floor():
			if !is_on_ground:
				is_attacking=false
			is_on_ground=true
		else:
			if !is_attacking:
				is_on_ground=false
				if velocity.y < 0:
					$Player_Anim.play("Jump")
				else:
					$Player_Anim.play("Fall")
		
	#	By setting velocity to return value of move and slide...
	#	it retains it's position after a jump or falling down
	#	Floor is the top of the tile
		velocity = move_and_slide(velocity,FLOOR)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Soldier" in get_slide_collision(i).collider.name:
					die()

func die():
	is_dead = true
	velocity = Vector2(0,0)
	$Player_Anim.play("Dead")
	$CollisionShape2D.set_deferred("disabled", true)
	$Timer.start()

func _on_Player_Anim_animation_finished():
	is_attacking=false

func _on_Timer_timeout():
	get_tree().change_scene("res://Title.tscn")

func crown_power_up():
	fireball_power = 2
