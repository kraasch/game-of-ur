extends Control

const MAIN_GAME : Resource = preload("res://visuals/prototype/prototype.tscn")
const INTRO_MUSIC : Resource =  preload("res://assets/music/intro/caves.ogg")
const DEFAULT_VOLUME_DB : float = 0.0
@onready var player : AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	Input.set_custom_mouse_cursor(MyUi.CURSOR_NORMAL)
	add_child(player)
	play_menu_music()

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		stop_music_and_change_scene()

func play_menu_music():
	if player.playing:
		return
	player.stream = INTRO_MUSIC
	player.bus = "Music"
	player.play()

func change_scene_and_reset_volume() -> void:
	player.volume_db = DEFAULT_VOLUME_DB
	get_tree().change_scene_to_packed(MAIN_GAME)

func stop_music_and_change_scene(fade_time: float = 1.5):
	if !player.playing:
		return
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(player, "volume_db", -80.0, fade_time)
	tween.tween_callback(player.stop)
	tween.tween_callback(change_scene_and_reset_volume)
