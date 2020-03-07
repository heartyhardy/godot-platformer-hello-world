extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/StartButton.grab_focus()

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/StartButton.is_hovered():
		$MarginContainer/VBoxContainer/VBoxContainer/StartButton.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/ExitButton.is_hovered():
		$MarginContainer/VBoxContainer/VBoxContainer/ExitButton.grab_focus()


func _on_StartButton_pressed():
	get_tree().change_scene("res://StageOne.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
