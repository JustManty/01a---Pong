class_name AIPaddle extends StaticBody2D

@export var speed: float = 200

@onready var sprite: Sprite2D = $Sprite2D
@onready var ball: Ball = $"../Ball"

var game_is_started: bool = false
var starting_positition: Vector2

func _physics_process(delta: float) -> void:
	if !GameController.is_paused:
		if self.position.y < ball.position.y and !is_colliding_bottom():
			self.position.y += speed * delta
		if self.position.y > ball.position.y and !is_colliding_top():
			self.position.y -= speed * delta

func _ready() -> void:
	starting_positition = self.position
	pass

func is_colliding_top() -> bool:
	return ( get_viewport_rect().position.y + ( sprite.texture.get_height() * sprite.scale.y / 2 ) ) > self.position.y

func is_colliding_bottom() -> bool:
	return ( get_viewport_rect().end.y - ( sprite.texture.get_height() * sprite.scale.y / 2 ) ) < self.position.y

func reset_horizontal_pos() -> void:
	self.position.x = starting_positition.x
