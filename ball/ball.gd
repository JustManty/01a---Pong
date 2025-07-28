class_name Ball extends CharacterBody2D

@export var speed : float = 100.0
@onready var sprite: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var game_is_started : bool = false
var start_position : Vector2

func _physics_process( delta: float ) -> void:	
	if !GameController.is_paused:
		# Handle vertical boundaries
		if(is_colliding_vertical_bound()):
			velocity.y *= -1
		
		# Handle paddle collisions 
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			velocity = velocity.bounce(collision.get_normal())
			if collision.get_collider() is AIPaddle or collision.get_collider() is PlayerPaddle:
				audio_stream_player.play()
				velocity *= 1.05
			break
		
		move_and_slide()

func _ready() -> void:
	start_position = self.position
	set_random_velocity()
	move_and_slide()

func is_colliding_vertical_bound() -> bool:
	var is_colliding_top : bool = ( get_viewport_rect().position.y + ( sprite.texture.get_height() / 2 ) ) > self.position.y
	var is_colliding_bottom : bool = ( get_viewport_rect().end.y - ( sprite.texture.get_height() / 2 ) ) < self.position.y
	return is_colliding_top || is_colliding_bottom
	
func start_game() -> void:
	game_is_started = true
	
func set_random_velocity() -> void:
	var random_start_velocity = Vector2.ZERO
	random_start_velocity.x = randi_range( -3, 3 )
	random_start_velocity.y = randi_range( -3, 3 )
	# Don't allow for zero horizontal velocity
	if random_start_velocity.x == 0: random_start_velocity.x = 1
	random_start_velocity = random_start_velocity.normalized()
	velocity = random_start_velocity * speed
