extends Node

const DEFAULT_SPEED := 100
const VELOCITIES := {
    "north": Vector2(0, DEFAULT_SPEED * -1),
    "south": Vector2(0, DEFAULT_SPEED),
    "east": Vector2(DEFAULT_SPEED, 0)
}
const INITIAL_VELOCITY := VELOCITIES.east

var spawned: Array[int] = []
var current_velocity: Vector2 = VELOCITIES.south

func set_velocity(new_velocity: Vector2):
    current_velocity = new_velocity