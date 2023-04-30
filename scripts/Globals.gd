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

var lane_direction: Globals.DIRECTIONS = DIRECTIONS.UNSET
var is_keyboard: bool = false
var available_sprite_indexes: Array[int] = []
var sprite_entrance_time := 3.0
var sprite_respawn_time := 3.0
var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.set_wait_time(5)
	timer.set_one_shot(false)
	timer.connect('timeout', Callable(self, 'make_harder'))
	add_child(timer)
	timer.start()

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

func make_harder():
	sprite_entrance_time *= 0.9
	sprite_respawn_time *= 0.9
