extends CharacterBody2D

@export var spawn_index: int

const default_x := 100
const default_y := 0

@export var adjusted_x := default_x
@export var adjusted_y := default_y

var current_movement_x := default_x
var current_movement_y := default_y

func _process(delta: float) -> void:
	if adjusted_x != current_movement_x:
		current_movement_x = adjusted_x
	if adjusted_y != current_movement_y:
		current_movement_y = adjusted_y
			
	move_and_collide(Vector2(current_movement_x * delta, current_movement_y * delta))

