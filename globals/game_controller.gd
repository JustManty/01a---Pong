extends Node2D

@onready var left_score: Label = $"Left Score"
@onready var right_score: Label = $"Right Score"

var game_started: bool = false
var score: Array[int] = [0,0]
signal start_game()

func _ready() -> void:
	pass
	
func _process( delta: float ) -> void:
	if( !game_started && Input.is_anything_pressed() ):
		start_game.emit()

func add_score( left_score_to_add : int, right_score_to_add : int ) -> void:
	print("adding score!")
	left_score.text = str( int( left_score.text ) + left_score_to_add )
	right_score.text = str( int (right_score.text ) + right_score_to_add )
