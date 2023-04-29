extends Node2D

@onready var data := preload("res://scenes/TestScene/Data.tscn")
@onready var action_window: Area2D = $FullWindow/Center/ActionWindow

var timer: Timer
var current_spawn_index := 0
var enemy_spawn: Vector2

func _ready():

	action_window.connect('body_exited', Callable(self, 'data_missed'))

	enemy_spawn = Vector2(20, get_viewport_rect().size.y / 2)

	timer = Timer.new()
	timer.set_wait_time(1)
	timer.set_one_shot(false)
	timer.connect('timeout', Callable(self, 'spawn_data'))
	add_child(timer)
	timer.start()

func _process(_delta):
	var collisions := action_window.get_overlapping_bodies()
	var next_data: CharacterBody2D = null
	if len(Globals.spawned) > 0 && len(collisions) > 0:
		for obj in collisions:
			if obj.get('spawn_index') != null && obj.spawn_index == Globals.spawned[0]:
				next_data = obj
				break

	if Input.is_action_just_pressed('primary_up') && next_data != null:
		Globals.spawned.pop_front()
		Globals.set_velocity(Globals.VELOCITIES.north)
		next_data = null


	elif Input.is_action_just_pressed('primary_right') && next_data != null:
		Globals.spawned.pop_front()
		Globals.set_velocity(Globals.VELOCITIES.east)
		next_data = null

	elif Input.is_action_just_pressed('primary_down') && next_data != null:
		Globals.spawned.pop_front()
		Globals.set_velocity(Globals.VELOCITIES.south)
		next_data = null
	
func spawn_data():
	var enemy = data.instantiate()
	enemy.spawn_index = current_spawn_index
	Globals.spawned.append(current_spawn_index)
	current_spawn_index += 1
	enemy.position = enemy_spawn
	add_child(enemy)
	timer.set_wait_time(5)
	timer.start()

func data_missed(body: Node2D):
	body.current_velocity = Globals.current_velocity
