extends Control

@onready var label: RichTextLabel = %label

@export var fsize : int = 50

func _ready() -> void:
	label.add_theme_font_size_override("normal_font_size", fsize)
	_change_letter()

func _change_letter() -> void:
	label.text = char(randi_range(65, 90)) # A-Z
	var timer : SceneTreeTimer = get_tree().create_timer(randf_range(3.0, 6.0))
	timer.timeout.connect(_change_letter)
