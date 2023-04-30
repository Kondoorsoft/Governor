extends Node2D

@onready var Sprite := preload('res://scenes/Sprites/Data.tscn')
@onready var GameOver := preload('res://scenes/Game Over.tscn')

@onready var background: Sprite2D = $FullWindow/Background
@onready var spawn_timer: Timer = $SpawnTimer
@onready var help_popup: ColorRect = $FullWindow/ColorRect

@onready var audio_stream_player_dead: AudioStreamPlayer = $AudioStreamPlayerDead
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var good_feedback: AudioStreamPlayer = $GoodFeedback
@onready var bad_feedback: AudioStreamPlayer = $BadFeedback

@onready var ne_button:= $FullWindow/NEButton
@onready var se_button:= $FullWindow/SEButton
@onready var sw_button:= $FullWindow/SWButton
@onready var nw_button:= $FullWindow/NWButton

@onready var n_button := $FullWindow/NButton
@onready var s_button := $FullWindow/SButton
@onready var e_button := $FullWindow/EButton

@onready var memory: ProgressBar = $Memory
@onready var score = $Score

var dead := false
var dead_sound := false
var spawn_point: Vector2
var center_screen: Vector2
var tween_speed := 0.5
var current_sprite: CharacterBody2D = null
var initial_sprite_at_cpu := false
var initial_sprite_instructed := false

func _ready():

	audio_stream_player_dead.connect('finished', Callable(self, 'audio_stream_player_dead_finished'))
	SignalBus.connect('correct_lane', Callable(self, 'correct_lane'))
	SignalBus.connect('incorrect_lane', Callable(self, 'incorrect_lane'))

	background.frame = 8
	score.text = '0'
	
	spawn_point = Vector2(-20, get_viewport_rect().size.y / 2)
	center_screen = get_viewport_rect().get_center()

	spawn_timer.set_one_shot(true)
	spawn_timer.connect('timeout', Callable(self, 'spawn_sprite'))
	spawn_sprite()
	
	if Globals.is_keyboard == true:
		ne_button.frame = 46
		nw_button.frame = 45
		se_button.frame = 47
		sw_button.frame = 44 

func _process(_delta):
	
	if Input.is_action_just_pressed('suicide'):
		dead = true
	
	if !dead && audio_stream_player.playing == false:
		audio_stream_player.play()
	
	if dead && audio_stream_player_dead.playing == false:
		audio_stream_player.stop()
		audio_stream_player_dead.play()
		dead_sound = true
	
	if initial_sprite_at_cpu:
		if Input.is_action_just_pressed('northwest'):
			instruct_sprites(4, Globals.DIRECTIONS.NORTHWEST)
		elif Input.is_action_just_pressed('north'):
			instruct_sprites(3, Globals.DIRECTIONS.NORTH)
		elif Input.is_action_just_pressed('northeast'):
			instruct_sprites(2, Globals.DIRECTIONS.NORTHEAST)
		elif Input.is_action_just_pressed('east'):
			instruct_sprites(1, Globals.DIRECTIONS.EAST)
		elif Input.is_action_just_pressed('southeast'):
			instruct_sprites(0, Globals.DIRECTIONS.SOUTHEAST)
		elif Input.is_action_just_pressed('south'):
			instruct_sprites(6, Globals.DIRECTIONS.SOUTH)
		elif Input.is_action_just_pressed('southwest'):
			instruct_sprites(5, Globals.DIRECTIONS.SOUTHWEST)

func _physics_process(_delta: float) -> void:
	if memory.value > 0:
		memory.value = memory.value - .03

func instruct_sprites(bg_frame: int, new_direction: Globals.DIRECTIONS):
	background.frame = bg_frame
	Globals.lane_direction = new_direction
	if !initial_sprite_instructed:
		initial_sprite_instructed = true
		help_popup.visible = false
		Globals.start_game()
		start_game()

func spawn_sprite():
	var new_sprite = Sprite.instantiate()
	new_sprite.position = spawn_point
	add_child(new_sprite)
	var tween = create_tween()
	tween.connect('finished', Callable(self, 'sprite_at_cpu').bind(new_sprite))
	tween.tween_property(new_sprite, 'position', center_screen, Globals.sprite_entrance_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.play()
	if initial_sprite_instructed:
		if !spawn_timer.is_stopped():
			spawn_timer.stop()
		spawn_timer.set_wait_time(Globals.sprite_respawn_time)
		spawn_timer.start()

func sprite_at_cpu(sprite: Node2D):
	sprite.set('waiting_instruction', true)
	
	if !initial_sprite_at_cpu:
		initial_sprite_at_cpu = true
		help_popup.visible = true

func start_game():
	spawn_timer.set_wait_time(Globals.sprite_respawn_time)
	spawn_timer.start()

func audio_stream_player_dead_finished() -> void:
	if dead_sound:
		get_tree().change_scene_to_packed(GameOver)

func correct_lane():
	good_feedback.play()
	var score_value = int(score.text)
	score_value += 10
	score.text = str(score_value)

func incorrect_lane():
	memory.value += 10
	if memory.value >= 100:
		spawn_timer.stop()
		dead = true
		Globals.final_score = score.text
	else:
		bad_feedback.play()
