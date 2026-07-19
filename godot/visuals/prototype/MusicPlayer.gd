extends RefCounted
class_name  MusicPlayer

signal mute_was_toggled(mute_status : bool)

const DEFAULT_MUSIC_VOLUME_DB : float = -20.0

var player := AudioStreamPlayer.new()

var tracks : Array[String] = [
	"res://assets/music/game/abf.ogg",
	"res://assets/music/game/ambient-main.ogg",
	"res://assets/music/game/ancient-ruins.ogg",
	"res://assets/music/game/ancient_robot.ogg",
	"res://assets/music/game/doodle.ogg",
	"res://assets/music/game/the-cave-of-the-ancient-warriors.ogg",
]

var current_track : int = 0

func toggle_mute() -> void:
	if player.playing:
		player.stop()
	else:
		player.play()
	mute_was_toggled.emit(player.playing)

func _init(parent_node : Node):
	tracks.shuffle()
	parent_node.add_child(player)
	player.finished.connect(_on_track_finished)
	play_music()

func play_music():
	player.volume_db = DEFAULT_MUSIC_VOLUME_DB
	player.stream = load(tracks[current_track])
	player.play()

func _on_track_finished():
	current_track = (current_track + 1) % tracks.size()
	play_music()
