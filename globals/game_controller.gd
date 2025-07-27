extends Node2D

var is_paused: bool = false
	
func pause() -> void:
	Engine.time_scale = 0
	is_paused = true

func resume() -> void:
	Engine.time_scale = 1
	is_paused = false
