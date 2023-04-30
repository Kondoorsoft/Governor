extends Control

@onready var Main = preload('res://scenes/Main.tscn')

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var ne_button:= $Label/NEButton
@onready var se_button:= $Label/SEButton
@onready var sw_button:= $Label/SWButton
@onready var nw_button:= $Label/NWButton

@onready var n_button := $Label/NButton
@onready var s_button := $Label/SButton
@onready var e_button := $Label/EButton

var timer: Timer
var can_continue := false

func _ready() -> void:
	audio_player.play()
	
	timer = Timer.new()
	timer.set_wait_time(0.5)
	timer.set_one_shot(true)
	timer.connect('timeout', func(): can_continue = true)
	add_child(timer)
	timer.start()

	if Globals.is_keyboard:
		ne_button.frame = 46
		nw_button.frame = 45
		se_button.frame = 47
		sw_button.frame = 44 
	else:
		ne_button.frame = 18
		nw_button.frame = 17
		se_button.frame = 19
		sw_button.frame = 16

func _input(event):
	if can_continue && Input.is_action_just_pressed('ui_accept'):
		if event is InputEventJoypadButton:
			Globals.is_keyboard = false
		else:
			Globals.is_keyboard = true
		get_tree().change_scene_to_packed(Main)
			
func _exit_tree() -> void:
	timer.stop()
	remove_child(timer)
