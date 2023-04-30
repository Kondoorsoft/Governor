extends Control

var timer: Timer
var can_continue := false

func _ready() -> void:
	timer = Timer.new()
	timer.set_wait_time(0.5)
	timer.set_one_shot(true)
	timer.connect('timeout', func(): can_continue = true)
	add_child(timer)
	timer.start()

func _process(_delta: float) -> void:
	if can_continue && Input.is_action_just_pressed('ui_accept'):
		get_tree().change_scene_to_file('res://scenes/TitleScreen.tscn')

func _exit_tree() -> void:
	timer.stop()
	remove_child(timer)
