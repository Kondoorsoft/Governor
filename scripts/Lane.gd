extends Node

class_name Lane

var lane_direction: Globals.DIRECTIONS
var sprite_velocity: Vector2
var sprite_frames: Array[int]

func _init(
    new_lane_direction: Globals.DIRECTIONS,
    new_sprite_velocity: Vector2,
    new_sprite_frames: Array[int]
) -> void:
    self.lane_direction = new_lane_direction
    self.sprite_velocity = new_sprite_velocity
    self.sprite_frames = new_sprite_frames