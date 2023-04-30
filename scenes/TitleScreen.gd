extends Control

@onready var Opening = preload('res://scenes/Opening.tscn')

@onready var animation_player: AnimationPlayer = $Label/AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var timer: Timer
var can_continue := false

func _ready() -> void:
	animation_player.play('blink')
	audio_stream_player.play()

	timer = Timer.new()
	timer.set_wait_time(0.5)
	timer.set_one_shot(true)
	timer.connect('timeout', func(): can_continue = true)
	add_child(timer)
	timer.start()
		
func _input(event):
	if can_continue && Input.is_action_just_pressed('ui_accept'):
		if event is InputEventJoypadButton:
			Globals.is_keyboard = false
		else:
			Globals.is_keyboard = true
		get_tree().change_scene_to_packed(Opening)
			
func _exit_tree() -> void:
	timer.stop()
	remove_child(timer)