extends Node2D

@onready var data := preload("res://scenes/Sprites/Data.tscn")
@onready var action_window: Area2D = $FullWindow/Center/ActionWindow
@onready var background: Sprite2D = $FullWindow/Background

@onready var ne_button:= $FullWindow/NEButton
@onready var se_button:= $FullWindow/SEButton
@onready var sw_button:= $FullWindow/SWButton
@onready var nw_button:= $FullWindow/NWButton

@onready var n_button := $FullWindow/NButton
@onready var s_button := $FullWindow/SButton
@onready var e_button := $FullWindow/EButton

var timer: Timer
var spawn_point: Vector2
var center_screen: Vector2
var tween_speed := 0.5

func _ready():

	action_window.connect('body_exited', Callable(self, 'data_missed'))

	spawn_point = Vector2(20, get_viewport_rect().size.y / 2)
	center_screen = get_viewport_rect().get_center()

	timer = Timer.new()
	timer.set_wait_time(1)
	timer.set_one_shot(false)
	timer.connect('timeout', Callable(self, 'spawn_data'))
	add_child(timer)
	timer.start()
	
	if Globals.is_keyboard == true:
		ne_button.frame = 46
		nw_button.frame = 45
		se_button.frame = 47
		sw_button.frame = 44 



func _process(_delta):
	var collisions := action_window.get_overlapping_bodies().filter(unprocessed)
	var next_sprite: CharacterBody2D = null
	if len(collisions) > 0:
		next_sprite = collisions[0]

	if next_sprite != null:
		if Input.is_action_just_pressed('northwest'):
			var tween := get_tree().create_tween()
			tween.set_ease(Tween.EASE_IN_OUT)
			tween.tween_property(next_sprite, 'position', center_screen, tween_speed)
			tween.tween_property(next_sprite, 'current_velocity', Vector2(0, 0), tween_speed) 
			Globals.set_velocity(next_sprite, Globals.VELOCITIES.northwest)
			background.frame = 4
		elif Input.is_action_just_pressed('north'):
			var tween := get_tree().create_tween()
			tween.set_ease(Tween.EASE_IN_OUT)
			tween.tween_property(next_sprite, 'current_velocity', Vector2(0, 0), tween_speed) 
			tween.tween_property(next_sprite, 'position', center_screen, tween_speed)
			Globals.set_velocity(next_sprite, Globals.VELOCITIES.north)
			background.frame = 3
		elif Input.is_action_just_pressed('northeast'):
			var tween := get_tree().create_tween()
			tween.tween_property(next_sprite, 'position', center_screen, tween_speed)
			Globals.set_velocity(next_sprite, Globals.VELOCITIES.northeast)
			background.frame = 2
		elif Input.is_action_just_pressed('east'):
			Globals.set_velocity(next_sprite, Globals.VELOCITIES.east)
			background.frame = 1
		elif Input.is_action_just_pressed('southeast'):
			var tween := get_tree().create_tween()
			tween.tween_property(next_sprite, 'position', center_screen, tween_speed)
			Globals.set_velocity(next_sprite, Globals.VELOCITIES.southeast)
			background.frame = 0
		elif Input.is_action_just_pressed('south'):
			var tween := get_tree().create_tween()
			tween.tween_property(next_sprite, 'position', center_screen, tween_speed)
			Globals.set_velocity(next_sprite, Globals.VELOCITIES.south)
			background.frame = 6
		elif Input.is_action_just_pressed('southwest'):
			var tween := get_tree().create_tween()
			tween.tween_property(next_sprite, 'position', center_screen, tween_speed)
			Globals.set_velocity(next_sprite, Globals.VELOCITIES.southwest)
			background.frame = 5

func unprocessed(body: Node2D):
	return body.get('processed') == false
	
func spawn_data():
	var sprite = data.instantiate()
	sprite.position = spawn_point
	add_child(sprite)
	timer.set_wait_time(1)
	timer.start()

func data_missed(body: Node2D):
	var previous_velocity = Globals.current_velocity
	# if previous_velocity != Globals.VELOCITIES.east:
	# 	var tween := get_tree().create_tween()
	# 	tween.tween_property(body, 'position', center_screen, tween_speed)
	body.set('current_velocity', previous_velocity)
	body.set('processed', true)
