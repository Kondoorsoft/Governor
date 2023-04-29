extends Node

const DEFAULT_SPEED := 100
const VELOCITIES := {
    "northwest": Vector2(DEFAULT_SPEED * -1, DEFAULT_SPEED * -1),
    "north": Vector2(0, DEFAULT_SPEED * -1),
    "northeast": Vector2(DEFAULT_SPEED, DEFAULT_SPEED * -1),
    "east": Vector2(DEFAULT_SPEED, 0),
    "southeast": Vector2(DEFAULT_SPEED, DEFAULT_SPEED),
    "south": Vector2(0, DEFAULT_SPEED),
    "southwest": Vector2(DEFAULT_SPEED * -1, DEFAULT_SPEED),
}
const INITIAL_VELOCITY := VELOCITIES.east

var spawned: Array[int] = []
var current_velocity: Vector2 = VELOCITIES.south

func set_velocity(body: Node2D, new_velocity: Vector2):
    body.set('current_velocity', new_velocity)
    body.set('processed', true)
    current_velocity = new_velocity