extends CanvasLayer
class_name  MyUi

const CURSOR_NORMAL: Resource = preload("res://assets/cursors/pointer_b.png")
const CURSOR_CAN_GRAB: Resource = preload("res://assets/cursors//hand_open.png")
const CURSOR_CAN_CLICK: Resource = preload("res://assets/cursors/hand_point.png")
const MUTED : Resource = preload("res://assets/icons/audioOff.png")
const LOUD : Resource = preload("res://assets/icons/audioOn.png")
const HIDE_PATHS_TEXTURE : Resource = preload("res://assets/icons/cross.png")
const SHOW_PATHS_TEXTURE : Resource = preload("res://assets/icons/larger.png")
const BUTTON_DISABLED : Resource = preload("res://assets/cursors/disabled.png")
const DICE_ENABLED : Resource = preload("res://assets/icons/return.png")
const CURSOR_HOLDING: Resource = preload("res://assets/cursors/hand_closed.png")
const GAMEPAD_1 : Resource = preload("res://assets/icons/gamepad1.png")
const GAMEPAD_2 : Resource = preload("res://assets/icons/gamepad2.png")
const GAMEPAD_3 : Resource = preload("res://assets/icons/gamepad3.png")
const GAMEPAD_4 : Resource = preload("res://assets/icons/gamepad4.png")
const GAMEPADS : Array[Resource] = [GAMEPAD_1, GAMEPAD_2, GAMEPAD_3, GAMEPAD_4]
const EYE_TEXTURE_UNKNOWN = preload("res://assets/cursors/look_d.png")
const UNKNOWN_TEXT : String = '?'

enum MOUSE {BEGIN_BUTTON_HOVER, END_BUTTON_HOVER}

@onready var button_sound : AudioStreamPlayer = AudioStreamPlayer.new()
@onready var credits_layer: CreditsLayer = %credits_layer
@onready var misc_container: Node3D = %misc_container
@onready var number_label: Label = %number_label
@onready var eye_1: TextureRect = %eye_1
@onready var eye_2: TextureRect = %eye_2
@onready var eye_3: TextureRect = %eye_3
@onready var eye_4: TextureRect = %eye_4
@onready var EYES : Array[TextureRect] = [eye_1, eye_2, eye_3, eye_4]

# buttons.
@onready var shader_button: TextureButton = %shader_button
@onready var reset_perspective_button: TextureButton = %reset_perspective_button
@onready var left_button: TextureButton = %left_button
@onready var right_button: TextureButton = %right_button
@onready var player_indicator: TextureRect = %player_indicator
@onready var settings_button: TextureButton = %settings_button
@onready var about_button: TextureButton = %about_button
@onready var pass_button: TextureButton = %pass_button
@onready var step_button: TextureButton = %step_button
@onready var prev_button: TextureButton = %prev_button
@onready var confirm_button: TextureButton = %confirm_button
@onready var next_button: TextureButton = %next_button
@onready var path_toggle: TextureButton = %path_toggle

@onready var buttons: Array[TextureButton] = [
	shader_button,
	reset_perspective_button,
	left_button,
	right_button,
	settings_button,
	about_button,
	pass_button,
	step_button,
	prev_button,
	confirm_button,
	next_button,
	path_toggle,
]

func update_path_toggle_face(show_paths : bool) -> void:
	if show_paths:
		path_toggle.texture_normal = HIDE_PATHS_TEXTURE
	else:
		path_toggle.texture_normal = SHOW_PATHS_TEXTURE

func _update_button(button : TextureButton, is_show : bool) -> void:
	button.visible = is_show
	button.disabled = not is_show

func update_navigation_ui(is_show : bool) -> void:
	for button : TextureButton in [prev_button, confirm_button, next_button]:
		_update_button(button, is_show)

func update_next_and_prev_ui(is_show : bool) -> void:
	for button : TextureButton in [prev_button, next_button]:
		_update_button(button, is_show)

func update_next_ui(is_show : bool) -> void:
	_update_button(next_button, is_show)

func update_prev_ui(is_show : bool) -> void:
	_update_button(prev_button, is_show)

func disable_dice() -> void:
	step_button.disabled = true
	step_button.modulate = Color.RED
	step_button.texture_normal = BUTTON_DISABLED
	step_button.visible = false

func enable_dice() -> void:
	step_button.disabled = false
	step_button.modulate = Color.WHITE
	step_button.texture_normal = DICE_ENABLED
	step_button.visible = true

func disable_pass() -> void:
	pass_button.disabled = true
	pass_button.visible = false

func enable_pass() -> void:
	pass_button.disabled = false
	pass_button.visible = true

func update_mute_button(new_mute_status : bool) -> void:
	settings_button.texture_normal = LOUD if new_mute_status else MUTED

func _on_about_button_pressed() -> void:
	credits_layer.visible = true
	get_viewport().gui_release_focus()

func play_button_sound():
	button_sound.play()

func update_ui_for_player(pid : int, color : Color) -> void:
	_update_gamepad_for_player(pid, color)

func reset_ui_for_dice_roll() -> void:
	for eye : TextureRect in EYES:
		eye.texture = EYE_TEXTURE_UNKNOWN
	number_label.visible = false
	number_label.text = UNKNOWN_TEXT

func _update_gamepad_for_player(pid : int, color : Color) -> void:
	if pid >= 0 and pid < len(GAMEPADS):
		player_indicator.texture = GAMEPADS[pid]
		if color:
			player_indicator.modulate = color
		else:
			player_indicator.modulate = Color.WHITE

func get_mouse(mouse: MOUSE) -> Resource:
	match mouse:
		MOUSE.END_BUTTON_HOVER:
			return CURSOR_NORMAL
		MOUSE.BEGIN_BUTTON_HOVER:
			return CURSOR_CAN_CLICK
	return CURSOR_NORMAL

func _ready() -> void:
	misc_container.add_child(button_sound)
	setup_ui_buttons()

func setup_ui_buttons() -> void:
	button_sound.stream = preload("res://assets/music/effects/menu-move.ogg")
	for button: TextureButton in buttons:
		button.focus_mode = Control.FOCUS_NONE
		var _on_hover = func():
			Input.set_custom_mouse_cursor(get_mouse(MOUSE.BEGIN_BUTTON_HOVER))
			button.modulate = Color.DARK_GRAY
		var _on_normal = func():
			Input.set_custom_mouse_cursor(get_mouse(MOUSE.END_BUTTON_HOVER))
			button.modulate = Color.WHITE
		var _on_pressed = func():
			button.modulate = Color.DIM_GRAY
		button.mouse_entered.connect(_on_hover)
		button.mouse_exited.connect(_on_normal)
		button.button_down.connect(_on_pressed)
		button.button_up.connect(_on_hover)
		# connect audio
		button.pressed.connect(play_button_sound)
