extends Control

@onready var resume: Label = $Resume
@onready var restart: Label = $Restart
@onready var exit: Label = $Exit

var selected_label:  Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selected_label = resume

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_labels() -> void:
	if selected_label == resume:
		resume.theme.get_color()
