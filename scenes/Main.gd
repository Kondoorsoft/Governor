extends Node2D

@onready var Sprite := preload("res://scenes/Sprites/Data.tscn")
@onready var background: Sprite2D = $FullWindow/Background

@onready var ne_button:= $FullWindow/NEButton
@onready var se_button:= $FullWindow/SEButton
@onready var sw_button:= $FullWindow/SWButton
@onready var nw_button:= $FullWindow/NWButton

@onready var n_button := $FullWindow/NButton
@onready var s_button := $FullWindow/SButton
@onready var e_button := $FullWindow/EButton

var timer: Timer
var spawn_point: Vector2
var center_screen: Vector2
var tween_speed := 0.5
var current_sprite: CharacterBody2D = null
var initial_sprite_at_cpu := false
var initial_sprite_instructed := false

func _ready():

	background.frame = 8

	spawn_point = Vector2(-20, get_viewport_rect().size.y / 2)
	center_screen = get_viewport_rect().get_center()

	spawn_sprite()
	
	if Globals.is_keyboard == true:
		ne_button.frame = 46
		nw_button.frame = 45
		se_button.frame = 47
		sw_button.frame = 44 

func _process(_delta):

	if initial_sprite_at_cpu:
		if Input.is_action_just_pressed('northwest'):
			instruct_sprites(4, Globals.DIRECTIONS.northwest)
		elif Input.is_action_just_pressed('north'):
			instruct_sprites(3, Globals.DIRECTIONS.north)
		elif Input.is_action_just_pressed('northeast'):
			instruct_sprites(2, Globals.DIRECTIONS.northeast)
		elif Input.is_action_just_pressed('east'):
			instruct_sprites(1, Globals.DIRECTIONS.east)
		elif Input.is_action_just_pressed('southeast'):
			instruct_sprites(0, Globals.DIRECTIONS.southeast)
		elif Input.is_action_just_pressed('south'):
			instruct_sprites(6, Globals.DIRECTIONS.south)
		elif Input.is_action_just_pressed('southwest'):
			instruct_sprites(5, Globals.DIRECTIONS.southwest)

func instruct_sprites(bg_frame: int, direction: Vector2):
	background.frame = bg_frame
	Globals.lane_direction = direction
	if !initial_sprite_instructed:
		initial_sprite_instructed = true
		start_game()

func spawn_sprite():
	var new_sprite = Sprite.instantiate()
	new_sprite.position = spawn_point
	add_child(new_sprite)
	var tween = create_tween()
	tween.connect('finished', Callable(self, 'sprite_at_cpu').bind(new_sprite))
	tween.tween_property(new_sprite, 'position', center_screen, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.play()

func sprite_at_cpu(sprite: Node2D):
	sprite.set('waiting_instruction', true)
	if !initial_sprite_at_cpu:
		initial_sprite_at_cpu = true

func start_game():
	timer = Timer.new()
	timer.set_wait_time(1)
	timer.set_one_shot(false)
	timer.connect('timeout', Callable(self, 'spawn_sprite'))
	add_child(timer)
	timer.start()

