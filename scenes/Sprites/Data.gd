extends CharacterBody2D

@onready var icon: Sprite2D = $CollisionShape2D/Sprite

@export var current_velocity: Vector2 = Vector2.ZERO
@export var waiting_instruction := false
@export var expected_lane: Globals.DIRECTIONS

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	var sprite_frame_index = rng.randi_range(0, len(Globals.available_sprite_indexes) - 1)
	var sprite_frame = Globals.available_sprite_indexes[sprite_frame_index]
	var lane = Globals.get_lane(sprite_frame)
	if lane:
		expected_lane = lane.lane_direction
	icon.frame = sprite_frame

func _process(delta: float) -> void:

	if waiting_instruction && Globals.lane_direction != Globals.DIRECTIONS.UNSET:
		var current_lane: Lane = Globals.LANES[Globals.lane_direction]
		current_velocity = current_lane.sprite_velocity
		if expected_lane == current_lane.lane_direction:
			SignalBus.correct_lane.emit()
		else:
			SignalBus.incorrect_lane.emit()
		waiting_instruction = false
	
	move_and_collide(Vector2(current_velocity.x * delta, current_velocity.y * delta))
