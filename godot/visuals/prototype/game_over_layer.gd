extends CanvasLayer
class_name MyGameOverLayer

signal was_closed()

func _unhandled_input(event: InputEvent) -> void:
	if not self.visible:
		return
	if event.is_pressed():
		was_closed.emit()
		self.visible = false
