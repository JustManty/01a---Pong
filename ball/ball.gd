class_name Ball extends CharacterBody2D

@export var speed : float = 100.0
@onready var sprite: Sprite2D = $Sprite2D
@onready var p1_paddle: Paddle = $"../P1 Paddle"
@onready var p2_paddle: Paddle = $"../P2 Paddle"
@onready var left_goal: Area2D = $"../Left Goal"
@onready var right_goal: Area2D = $"../Right Goal"

var game_is_started : bool = false

func _process( delta: float ) -> void:
	if( !game_is_started ): return

func _physics_process( delta: float ) -> void:
	if( !game_is_started ): return
	
	# Handle collisions
	if(is_colliding_vertical_bound()): velocity.y *= -1
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		velocity = velocity.bounce(collision.get_normal())
		break
	
	move_and_slide()

func _ready() -> void:
	GameController.start_game.connect( start_game )
	left_goal.body_entered.connect( left_score )
	right_goal.body_entered.connect( right_score )
	velocity = get_random_velocity()
	move_and_slide()

func is_colliding_vertical_bound() -> bool:
	var is_colliding_top : bool = ( get_viewport_rect().position.y + ( sprite.texture.get_height() / 2 ) ) > self.position.y
	var is_colliding_bottom : bool = ( get_viewport_rect().end.y - ( sprite.texture.get_height() / 2 ) ) < self.position.y
	return is_colliding_top || is_colliding_bottom
	
func start_game() -> void:
	game_is_started = true
	
func get_random_velocity() -> Vector2:
	var random_start_velocity = Vector2.ZERO
	random_start_velocity.x = randi_range( -3, 3 )
	random_start_velocity.y = randi_range( -3, 3 )
	# Don't allow for zero horizontal velocity
	if random_start_velocity.x == 0: random_start_velocity.x = 1
	random_start_velocity = random_start_velocity.normalized()
	return random_start_velocity * speed
	
func score( left_score_to_add: int, right_score_to_add: int ) -> void:
	game_is_started = false
	GameController.add_score( left_score_to_add, right_score_to_add )
	position = Vector2( get_viewport_rect().end / 2 )
	
func left_score() -> void:
	score( 1, 0 )
	
func right_score() -> void:
	score( 0, 1 )
