extends Control

#@onready var scene = preload("res://scenes/Opening.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label/AnimationPlayer.play('blink')
	$AudioStreamPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:	
	pass
		
func _input(event):
		if Input.is_action_just_pressed('ui_accept'):
			if event is InputEventJoypadButton:
				Globals.is_keyboard = false
				print('is controller')
			else:
				Globals.is_keyboard = true
				print('is keyboard')
			get_tree().change_scene_to_file('res://scenes/Opening.tscn')
			
		
