extends Control

@onready var Credits := preload('res://scenes/Credits.tscn')

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var score_label: Label = $ScoreLable

func _ready() -> void:
	audio_stream_player.play()
	score_label.text = "FINAL SCORE: " + Globals.final_score

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('ui_accept'):
		Globals.reset_game()
		get_tree().change_scene_to_packed(Credits)
