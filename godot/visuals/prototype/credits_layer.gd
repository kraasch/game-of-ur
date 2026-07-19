extends CanvasLayer
class_name  CreditsLayer

@onready var label_0 : RichTextLabel = %label_0
@onready var label_1 : RichTextLabel = %label_1
@onready var label_2 : RichTextLabel = %label_2
@onready var corner_code_repo_weblink : RichTextLabel = %corner_code_repo_weblink
@onready var labels : Array[RichTextLabel] = [
	label_0,
	label_1,
	label_2,
	corner_code_repo_weblink,
]

func _ready() -> void:
	for label : RichTextLabel in labels:
		label.meta_clicked.connect(_on_link_clicked)

func _on_link_clicked(meta):
	OS.shell_open(str(meta))

func _unhandled_input(event: InputEvent) -> void:
	if not self.visible:
		return
	if event.is_pressed():
		self.visible = false
