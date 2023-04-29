extends CharacterBody2D

@export var spawn_index: int
@export var current_velocity: Vector2 = Globals.INITIAL_VELOCITY
@export var processed := false

func _process(delta: float) -> void:
	move_and_collide(Vector2(current_velocity.x * delta, current_velocity.y * delta))

