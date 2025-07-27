class_name Game extends Node2D

@onready var left_score: Label = $"Game/Left Score"
@onready var right_score: Label = $"Game/Right Score"
@onready var ball: Ball = $"Game/Ball"
@onready var p1_paddle: Paddle = $"Game/P1 Paddle"
@onready var p2_paddle: Paddle = $"Game/P2 Paddle"


var game_started: bool = false
var score: Array[int] = [0,0]

func _ready() -> void:
	Engine.time_scale = 0
	pass

func _process( delta: float ) -> void:
	if( !game_started && Input.is_anything_pressed() ):
		start_game()

func start_game() -> void:
	Engine.time_scale = 1
	game_started = true

func pause_game() -> void:
	Engine.time_scale = 0
	game_started = false

func reset_game_positions() -> void:
	ball.position = ball.start_position
	p1_paddle.position = p1_paddle.starting_positition
	p2_paddle.position = p2_paddle.starting_positition

func update_scoreboard() -> void:
	left_score.text = str( score[0] )
	right_score.text = str( score[1] )

func _on_left_goal_body_entered(body: Node2D) -> void:
	pause_game()
	reset_game_positions()
	ball.set_random_velocity()
	score[1] += 1
	update_scoreboard()

func _on_right_goal_body_entered(body: Node2D) -> void:
	pause_game()
	reset_game_positions()
	ball.set_random_velocity()
	score[0] += 1
	update_scoreboard()
	
func handle_pause_menu() -> void:
	pause_game()

func display_pause_menu() -> void:
	var game = $Game
	var pause_menu = $"Pause Menu"
	for child:CanvasItem in game.get_children():
		child.hide()
	for child:CanvasItem in pause_menu.get_children():
		child.show()

func hide_pause_menu() -> void:
	var game = $Game
	var pause_menu = $"Pause Menu"
	for child:CanvasItem in game.get_children():
		child.show()
	for child:CanvasItem in pause_menu.get_children():
		child.hide()
