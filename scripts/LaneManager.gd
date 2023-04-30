extends Area2D

@export var lane: String

func _ready() -> void:
	print("Lane: ", self.name)
	print("Expecting: ", lane)

func _process(_delta: float) -> void:
	var collisions := self.get_overlapping_areas()
	if collisions.size() > 0:
		print("####################")
		print("Lane: ", self.name)
		print("Collisions: ", collisions)
