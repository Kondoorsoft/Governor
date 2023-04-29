extends Node2D

@onready var data := preload("res://scenes/Sprites/Data.tscn")
@onready var action_window: Area2D = $FullWindow/Center/ActionWindow
@onready var background: Sprite2D = $FullWindow/Background

var timer: Timer
var spawn_point: Vector2

func _ready():

	action_window.connect('body_exited', Callable(self, 'data_missed'))

	spawn_point = Vector2(20, get_viewport_rect().size.y / 2)

	timer = Timer.new()
	timer.set_wait_time(1)
	timer.set_one_shot(false)
	timer.connect('timeout', Callable(self, 'spawn_data'))
	add_child(timer)
	timer.start()

func _process(_delta):
	var collisions := action_window.get_overlapping_bodies().filter(unprocessed)
	var next_data: CharacterBody2D = null
	if len(collisions) > 0:
		next_data = collisions[0]

	if next_data != null:
		if Input.is_action_just_pressed('northwest'):
			Globals.set_velocity(next_data, Globals.VELOCITIES.northwest)
			background.frame = 4
		elif Input.is_action_just_pressed('north'):
			Globals.set_velocity(next_data, Globals.VELOCITIES.north)
			background.frame = 3
		elif Input.is_action_just_pressed('northeast'):
			Globals.set_velocity(next_data, Globals.VELOCITIES.northeast)
			background.frame = 2
		elif Input.is_action_just_pressed('east'):
			Globals.set_velocity(next_data, Globals.VELOCITIES.east)
			background.frame = 1
		elif Input.is_action_just_pressed('southeast'):
			Globals.set_velocity(next_data, Globals.VELOCITIES.southeast)
			background.frame = 0
		elif Input.is_action_just_pressed('south'):
			Globals.set_velocity(next_data, Globals.VELOCITIES.south)
			background.frame = 6
		elif Input.is_action_just_pressed('southwest'):
			Globals.set_velocity(next_data, Globals.VELOCITIES.southwest)
			background.frame = 5

func unprocessed(body: Node2D):
	return body.get('processed') == false
	
func spawn_data():
	var sprite = data.instantiate()
	sprite.position = spawn_point
	add_child(sprite)
	timer.set_wait_time(0.5)
	timer.start()

func data_missed(body: Node2D):
	body.set('current_velocity', Globals.current_velocity)
	body.set('processed', true)
