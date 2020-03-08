extends Node2D

var current_shake_priority = 0

func _ready():
	pass # Replace with function body.

func move_camera(vector):
	get_parent().get_node("Player").get_node("Player_Cam").offset = Vector2(rand_range(-vector.x, vector.x), rand_range(-vector.y,vector.y))

func screen_shake(shake_len, shake_force, shake_priority):
	if shake_priority > current_shake_priority:
		current_shake_priority = shake_priority
		$Tween.interpolate_method(self, "move_camera",Vector2(shake_force, shake_force), Vector2(0,0), shake_len, Tween.TRANS_SINE,Tween.EASE_OUT, 0)
		$Tween.start()		


func _on_Tween_tween_completed(_object, _key):
	current_shake_priority = 0
