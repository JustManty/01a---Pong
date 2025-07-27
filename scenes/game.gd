class_name Game extends Node2D

@onready var left_score: Label = $"Left Score"
@onready var right_score: Label = $"Right Score"
@onready var left_goal: Area2D = $"Left Goal"
@onready var right_goal: Area2D = $"Right Goal"
@onready var ball: Ball = $Ball
@onready var p1_paddle: Paddle = $"P1 Paddle"
@onready var p2_paddle: Paddle = $"P2 Paddle"

var game_started: bool = false
var score: Array[int] = [0,0]

func _ready() -> void:
	Engine.time_scale = 0
	left_goal.body_entered.connect(add_left_score)
	right_goal.body_entered.connect(add_right_score)
	pass

func _process( delta: float ) -> void:
	if( !game_started && Input.is_anything_pressed() ):
		start_game()

func add_left_score() -> void:
	left_score.text = str( int( left_score.text ) + 1 )

func add_right_score() -> void:
	right_score.text = str( int (right_score.text ) + 1 )

func start_game() -> void:
	Engine.time_scale = 1

func pause_game() -> void:
	Engine.time_scale = 0

func reset_game_positions() -> void:
	ball.position = ball.start_position
	p1_paddle.position = p1_paddle.starting_positition
	p2_paddle.position = p2_paddle.starting_positition
