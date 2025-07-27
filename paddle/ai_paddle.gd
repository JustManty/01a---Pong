class_name Paddle extends StaticBody2D

enum player { LEFT, RIGHT }

@export var speed: float = 200
@export var player_slot : player

@onready var sprite: Sprite2D = $Sprite2D
var game_is_started: bool = false
var starting_positition: Vector2

func _physics_process(delta: float) -> void:
	if !GameController.is_paused:
		if Input.is_action_pressed( "P" + get_player_number_as_string() + " Up" ) and !is_colliding_top():
			self.position.y -= speed * delta
		elif Input.is_action_pressed( "P" + get_player_number_as_string() + " Down" ) and !is_colliding_bottom():
			self.position.y += speed * delta

func _ready() -> void:
	starting_positition = self.position
	pass

func is_colliding_top() -> bool:
	return ( get_viewport_rect().position.y + ( sprite.texture.get_height() * sprite.scale.y / 2 ) ) > self.position.y

func is_colliding_bottom() -> bool:
	return ( get_viewport_rect().end.y - ( sprite.texture.get_height() * sprite.scale.y / 2 ) ) < self.position.y

func reset_horizontal_pos() -> void:
	self.position.x = starting_positition.x
	
func get_player_number_as_string() -> String:
	match player_slot:
		player.LEFT:
			return "1"
		player.RIGHT:
			return "2"
		_:
			push_error("player_slot was NULL in get_player_number_as_string()!")
			return "null"
