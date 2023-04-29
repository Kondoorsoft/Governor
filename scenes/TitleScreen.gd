extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label/AnimationPlayer.play('blink')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:	
	if Input.is_action_pressed('ui_accept'):
		get_tree().change_scene_to_file('res://scenes/Opening.tscn')
