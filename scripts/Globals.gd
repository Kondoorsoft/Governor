extends Node

var lane_direction: Vector2 = Vector2.ZERO
var is_keyboard: bool = false

const DEFAULT_ENTRANCE_SPEED := 3
const DEFAULT_RESPAWN_TIME := 3
const DEFAULT_EXIT_SPEED := 100
const DIRECTIONS := {
	"northwest": Vector2(DEFAULT_EXIT_SPEED * -1, DEFAULT_EXIT_SPEED * -1),
	"north": Vector2(0, DEFAULT_EXIT_SPEED * -1),
	"northeast": Vector2(DEFAULT_EXIT_SPEED, DEFAULT_EXIT_SPEED * -1),
	"east": Vector2(DEFAULT_EXIT_SPEED, 0),
	"southeast": Vector2(DEFAULT_EXIT_SPEED, DEFAULT_EXIT_SPEED),
	"south": Vector2(0, DEFAULT_EXIT_SPEED),
	"southwest": Vector2(DEFAULT_EXIT_SPEED * -1, DEFAULT_EXIT_SPEED),
}

### Sprite Column Starting Indexes
# 0
# 8
# 16
# 24
# 32
# 40
# 48

const SPRITE_DESTINATIONS = {
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
	#37: "W",
	38: "E",
	#39: "W",
	40: "N",
	48: "S",
	49: "E",
	#50: "W"	
}
var available_sprite_indexes = SPRITE_DESTINATIONS.keys()
