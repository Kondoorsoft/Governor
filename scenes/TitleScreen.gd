extends Control

@onready var Opening = preload('res://scenes/Opening.tscn')

@onready var animation_player: AnimationPlayer = $Label/AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	animation_player.play('blink')
	audio_stream_player.play()
		
func _input(event):
	if Input.is_action_just_pressed('ui_accept'):
		if event is InputEventJoypadButton:
			Globals.is_keyboard = false
		else:
			Globals.is_keyboard = true
		get_tree().change_scene_to_packed(Opening)
			
		
