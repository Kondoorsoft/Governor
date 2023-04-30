extends Node

const EXIT_SPEED := 100

enum DIRECTIONS {
	UNSET,
	NORTHWEST,
	NORTH,
	NORTHEAST,
	EAST,
	SOUTHEAST,
	SOUTH,
	SOUTHWEST,
}

### Sprite Column Starting Indexes
# 0
# 8
# 16
# 24
# 32
# 40
# 48

var LANES := {
	DIRECTIONS.NORTHWEST: Lane.new(
		DIRECTIONS.NORTHWEST, 
		Vector2(EXIT_SPEED * -1, EXIT_SPEED * -1),
		[5, 12, 30]
	),
	DIRECTIONS.NORTH: Lane.new(
		DIRECTIONS.NORTH, 
		Vector2(0, EXIT_SPEED * -1),
		[14, 34, 40]
	),
	DIRECTIONS.NORTHEAST: Lane.new(
		DIRECTIONS.NORTHEAST, 
		Vector2(EXIT_SPEED, EXIT_SPEED * -1),
		[4, 11, 33]
	),
	DIRECTIONS.EAST: Lane.new(
		DIRECTIONS.EAST, 
		Vector2(EXIT_SPEED, 0),
		[36, 38, 49]
	),
	DIRECTIONS.SOUTHEAST: Lane.new(
		DIRECTIONS.SOUTHEAST, 
		Vector2(EXIT_SPEED, EXIT_SPEED),
		[3, 10, 31]
	),
	DIRECTIONS.SOUTH: Lane.new(
		DIRECTIONS.SOUTH, 
		Vector2(0, EXIT_SPEED),
		[32, 35, 48]
	),
	DIRECTIONS.SOUTHWEST: Lane.new(
		DIRECTIONS.SOUTHWEST, 
		Vector2(EXIT_SPEED * -1, EXIT_SPEED),
		[2, 9, 29]
	),
}

const DEFAULT_ENTRANCE_TIME := 3.0
const DEFAULT_RESPAWN_TIME := 3.0

var lane_direction: Globals.DIRECTIONS = DIRECTIONS.UNSET
var available_sprite_indexes: Array[int] = []

var is_keyboard: bool = false

var sprite_entrance_time := DEFAULT_ENTRANCE_TIME
var sprite_minimum_entrance_time := 1.0
var sprite_respawn_time := DEFAULT_RESPAWN_TIME
var timer_interval := 5.0
var timer_name := "GlobalTimer"

var final_score := "0"

func _ready() -> void:
	var timer := Timer.new()
	timer.name = timer_name
	timer.set_one_shot(false)
	timer.connect('timeout', Callable(self, 'increase_difficulty'))
	add_child(timer)

	var lanes = LANES.values()
	for lane in lanes:
		for frame in lane.sprite_frames:
			available_sprite_indexes.append(frame)

func _process(_delta):
	if Input.is_action_just_pressed('quit'):
		get_tree().quit()

func get_lane(frame_index: int) -> Lane:
	for lane in LANES.values():
		if frame_index in lane.sprite_frames:
			return lane
	return null

func increase_difficulty():
	if sprite_entrance_time >= sprite_minimum_entrance_time:
		sprite_entrance_time *= 0.9
	sprite_respawn_time *= 0.9

func start_game():
	var timer: Timer = get_node(timer_name)
	timer.set_wait_time(timer_interval)
	timer.start()

func reset_game():
	sprite_entrance_time = DEFAULT_ENTRANCE_TIME
	sprite_respawn_time = DEFAULT_RESPAWN_TIME
	final_score = "0"
	lane_direction = DIRECTIONS.UNSET
	var timer: Timer = get_node(timer_name)
	timer.stop()