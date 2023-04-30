extends Node

const DEFAULT_ENTRANCE_SPEED := 3
const DEFAULT_RESPAWN_TIME := 3
const DEFAULT_EXIT_SPEED := 100

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
		Vector2(DEFAULT_EXIT_SPEED * -1, DEFAULT_EXIT_SPEED * -1),
		[5, 12, 30]
	),
	DIRECTIONS.NORTH: Lane.new(
		DIRECTIONS.NORTH, 
		Vector2(0, DEFAULT_EXIT_SPEED * -1),
		[14, 34, 40]
	),
	DIRECTIONS.NORTHEAST: Lane.new(
		DIRECTIONS.NORTHEAST, 
		Vector2(DEFAULT_EXIT_SPEED, DEFAULT_EXIT_SPEED * -1),
		[4, 11, 33]
	),
	DIRECTIONS.EAST: Lane.new(
		DIRECTIONS.EAST, 
		Vector2(DEFAULT_EXIT_SPEED, 0),
		[36, 38, 49]
	),
	DIRECTIONS.SOUTHEAST: Lane.new(
		DIRECTIONS.SOUTHEAST, 
		Vector2(DEFAULT_EXIT_SPEED, DEFAULT_EXIT_SPEED),
		[3, 10, 31]
	),
	DIRECTIONS.SOUTH: Lane.new(
		DIRECTIONS.SOUTH, 
		Vector2(0, DEFAULT_EXIT_SPEED),
		[32, 35, 48]
	),
	DIRECTIONS.SOUTHWEST: Lane.new(
		DIRECTIONS.SOUTHWEST, 
		Vector2(DEFAULT_EXIT_SPEED * -1, DEFAULT_EXIT_SPEED),
		[2, 9, 29]
	),
}

var lane_direction: Globals.DIRECTIONS = DIRECTIONS.UNSET
var is_keyboard: bool = false
var available_sprite_indexes: Array[int] = []

func _ready() -> void:
	var lanes = LANES.values()
	for lane in lanes:
		for frame in lane.sprite_frames:
			available_sprite_indexes.append(frame)

	print(available_sprite_indexes)

func _process(_delta):
	if Input.is_action_just_pressed('quit'):
		get_tree().quit()

func get_lane(frame_index: int) -> Lane:
	for lane in LANES.values():
		if frame_index in lane.sprite_frames:
			return lane
	return null
