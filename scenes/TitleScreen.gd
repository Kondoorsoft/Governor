extends Control

@onready var Scene = preload('res://scenes/Opening.tscn')

func _ready() -> void:
	$Label/AnimationPlayer.play('blink')
	$AudioStreamPlayer.play()
		
func _input(event):
	if Input.is_action_just_pressed('ui_accept'):
		if event is InputEventJoypadButton:
			Globals.is_keyboard = false
		else:
			Globals.is_keyboard = true
		get_tree().change_scene_to_packed(Scene)
			
		
