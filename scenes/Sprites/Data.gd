extends CharacterBody2D

@onready var icon: Sprite2D = $CollisionShape2D/Sprite

@export var spawn_index: int
@export var current_velocity: Vector2 = Vector2.ZERO
@export var waiting_instruction := false

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	var sprite_index = rng.randi_range(0, len(Globals.available_sprite_indexes) - 1)
	var sprite_frame = Globals.available_sprite_indexes[sprite_index]
	icon.frame = sprite_frame

func _process(delta: float) -> void:

	if waiting_instruction && Globals.lane_direction != Vector2.ZERO:
		current_velocity = Globals.lane_direction
		waiting_instruction = false
	
	move_and_collide(Vector2(current_velocity.x * delta, current_velocity.y * delta))
