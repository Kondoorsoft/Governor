extends Node2D

@onready var data := preload("res://scenes/TestScene/Data.tscn")
@onready var action_window: Area2D = $ActionWindow

var timer: Timer
var current_spawn_index := 0
var enemy_spawn: Vector2

func _ready():

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
			if obj.name == 'Data' && obj.spawn_index == Globals.spawned[0]:
				next_data = obj
				print(Globals.spawned)
				print(next_data)
				print(next_data.spawn_index)
				break

	if Input.is_action_just_pressed('primary_up') && next_data != null:
		Globals.spawned.pop_front()
		next_data.adjusted_x = 0
		next_data.adjusted_y = -90

func spawn_data():
	var enemy = data.instantiate()
	enemy.spawn_index = current_spawn_index
	Globals.spawned.append(current_spawn_index)
	current_spawn_index += 1
	enemy.position = enemy_spawn
	add_child(enemy)
	timer.set_wait_time(5)
	timer.start()
