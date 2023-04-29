extends CharacterBody2D

@export var spawn_index: int
@export var current_velocity: Vector2 = Globals.INITIAL_VELOCITY
@export var waiting_instruction := false

@export var sprite_index:= 4
@onready var dest_lane: String

# 0
# 8
# 16
# 24
# 32
# 40
# 48

const sprite_directions = {
	#DIAGS
	2: "SW",
	3: "SE",
	4: "NE",
	5: "NW",
	9: "SW",
	10: "SE",
	11: "NE",
	12: "NW",
	29: "SW",
	30: "NW",
	31: "SE",
	33: "NE",
	
	#STRAIGHTS
	14: "N",
	32: "S",
	34: "N",
	35: "S",
	36: "E",
	37: "W",
	38: "E",
	39: "W",
	40: "N",
	48: "S",
	49: "E",
	50: "W"
	
}
var available_sprite_indexes = sprite_directions.keys()


func _process(delta: float) -> void:
	move_and_collide(Vector2(current_velocity.x * delta, current_velocity.y * delta))
	if sprite_index == 4 || sprite_index == 11 || sprite_index == 33:
		dest_lane = 'NE'
	if sprite_index == 2 || sprite_index == 12 || sprite_index == 30:
		dest_lane = 'NW'
	if sprite_index == 3 || sprite_index == 10 || sprite_index == 31:
		dest_lane = 'SE'
	if sprite_index == 2 || sprite_index == 9 || sprite_index == 29: 
		dest_lane = 'SW'
	if sprite_index == 14 || sprite_index == 34 || sprite_index == 48:
		dest_lane = 'N'
	if sprite_index == 44 || sprite_index == 46 || sprite_index == 56:
		dest_lane = 'S'
	if sprite_index == 4 || sprite_index == 11 || sprite_index == 33:
		dest_lane = 'E'
