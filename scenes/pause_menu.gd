extends Control

@onready var resume: RichTextLabel = $Resume
@onready var restart: RichTextLabel = $Restart
@onready var exit: RichTextLabel = $Exit

signal resume_selected

var selected_label:  RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selected_label = resume
	update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameController.is_paused:
		if Input.is_action_just_pressed("ui_down"):
			select_next_label_down()
		if Input.is_action_just_pressed("ui_up"):
			select_next_label_up()
		if Input.is_action_just_pressed("ui_select"):
			handle_select()
		
func handle_select() -> void:
	match selected_label:
		resume:
			resume_selected.emit()
		restart:
			get_tree().reload_current_scene()
		exit:
			get_tree().quit()
		
func select_next_label_down() -> void:
	match selected_label:
		resume:
			selected_label = restart
		restart:
			selected_label = exit
		exit:
			selected_label = resume
	update_labels()

func select_next_label_up() -> void:
	match selected_label:
		resume:
			selected_label = exit
		restart:
			selected_label = resume
		exit:
			selected_label = restart
	update_labels()

func update_labels() -> void:
	const selected_color = Color.NAVY_BLUE
	if selected_label == resume:
		(resume.get_child(0) as ColorRect).color = selected_color
	else:
		(resume.get_child(0) as ColorRect).color = Color.TRANSPARENT
	if selected_label == restart:
		(restart.get_child(0) as ColorRect).color = selected_color
	else:
		(restart.get_child(0) as ColorRect).color = Color.TRANSPARENT
	if selected_label == exit:
		(exit.get_child(0) as ColorRect).color = selected_color
	else:
		(exit.get_child(0) as ColorRect).color = Color.TRANSPARENT
