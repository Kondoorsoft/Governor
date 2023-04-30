extends CharacterBody2D

@export var spawn_index: int
@export var current_velocity: Vector2 = Vector2.ZERO
@export var waiting_instruction := false

func _process(delta: float) -> void:

	if waiting_instruction && Globals.lane_direction != Vector2.ZERO:
		current_velocity = Globals.lane_direction
		waiting_instruction = false
	
	move_and_collide(Vector2(current_velocity.x * delta, current_velocity.y * delta))
