extends Node3D
class_name Prototype

#############
# signals   #
#############

#############
# enums     #
#############

#############
# constants #
#############

const ACTIVE_EYE   : Resource = preload("res://assets/cursors/look_a.png")
const INACTIVE_EYE : Resource = preload("res://assets/cursors/look_b.png")
const IS_DEBUG : bool = false

#############
# exports   #
#############

#############
# on-readys #
#############

@onready var game_over_layer: MyGameOverLayer = %game_over_layer
@onready var game_over_result_label: RichTextLabel = %game_over_result_label
@onready var credits_layer : CanvasLayer = %credits_layer
@onready var ui_layer : MyUi = %ui_layer
@onready var cam : MyCam = %cam
@onready var environment_container : Node3D = %environment_container
@onready var debug_container : Node3D = %debug_container
@onready var misc_container : Node3D = %misc_container
@onready var map_center_pill : MeshInstance3D = %map_center_pill
@onready var eye_1 : TextureRect = %eye_1
@onready var eye_2 : TextureRect = %eye_2
@onready var eye_3 : TextureRect = %eye_3
@onready var eye_4 : TextureRect = %eye_4
@onready var all_eyes : Array[TextureRect] = [eye_1, eye_2, eye_3, eye_4]
@onready var number_label: Label = %number_label
@onready var level_label: Label = %level_label

#############
# varaibles #
#############

var field_scene: PackedScene = preload("res://visuals/enteties/field/field.tscn")
var final_scene: PackedScene = preload("res://visuals/enteties/final/final.tscn")

var world_debug : WorldDebug
var music_player : MusicPlayer
var game : Game
#var graph : Graph # TODO: implement later.

#############
# build-ins #
#############

func _ready() -> void:
	_setup_debug()
	map_center_pill.visible = false
	# music player.
	music_player = MusicPlayer.new(misc_container)
	music_player.mute_was_toggled.connect(ui_layer.update_mute_button)
	# setup game
	_setup_game()
	# setup graph. # TODO: implement later.
	#_setup_graph()

func _setup_debug() -> void:
	cam.set_is_debug(IS_DEBUG)
	if not IS_DEBUG:
		ui_layer.reset_perspective_button.visible = false
		ui_layer.reset_perspective_button.disabled = true
		ui_layer.shader_button.visible = false
		ui_layer.shader_button.disabled = true
		map_center_pill.visible = true
		world_debug = WorldDebug.new(debug_container)
		world_debug.create_debug_bounding_box()

func _setup_game() -> void:
	game = Game.new()
	game_over_layer.was_closed.connect(game.on_start_a_new_game)
	# TODO: pull this into the game's connect_game() method.
	game.was_dice_roll.connect(_roll_the_dice)
	game.change_navigation_visibility.connect(ui_layer.update_navigation_ui)
	game.change_left_right_visibility.connect(ui_layer.update_next_and_prev_ui)
	game.change_right_visibility.connect(ui_layer.update_next_ui)
	game.change_left_visibility.connect(ui_layer.update_prev_ui)
	game.freeze_dice.connect(ui_layer.disable_dice)
	game.unfreeze_dice.connect(ui_layer.enable_dice)
	game.freeze_pass_turn.connect(ui_layer.disable_pass)
	game.unfreeze_pass_turn.connect(ui_layer.enable_pass)
	game.player_changed.connect(ui_layer.update_ui_for_player)
	game.reset_dice.connect(ui_layer.reset_ui_for_dice_roll)
	game.winner_is.connect(_show_winner)
	game.level_changed.connect(_update_level_label)
	game.connect_game(
			field_scene, 
			final_scene,
			environment_container,
			map_center_pill.global_position,
		)

#func _setup_graph() -> void: # TODO: implement later.
	#var edges = [
		#[Vector3(0,0,0), Vector3(2,0,0)],
		#[Vector3(2,0,0), Vector3(2,0,2)],
		#[Vector3(2,0,2), Vector3(0,0,1)],
	#]
	#graph = Graph.new(debug_container)
	#graph.draw_graph(edges, Color.RED)

func _unhandled_input(event):
	# NOTE: useful for debugging, this leaves the game when hitting the ESC key.
	if event.is_action_pressed("ui_cancel"):
		if OS.has_feature("editor"):
			get_tree().quit()
	if event.is_action_pressed("my_about"):
		if ui_layer:
			ui_layer._on_about_button_pressed()
	if event.is_action_pressed("my_mute"):
		_on_settings_button_pressed()
	if event.is_action_pressed("my_next_level"):
		_on_left_button_pressed()
	if event.is_action_pressed("my_prev_level"):
		_on_right_button_pressed()
	if event.is_action_pressed("my_next"):
		_on_next_button_pressed()
	if event.is_action_pressed("my_prev"):
		_on_prev_button_pressed()
	if event.is_action_pressed("my_pass"):
		_on_pass_button_pressed()
	if event.is_action_pressed("my_roll"):
		_on_step_button_pressed()
	if event.is_action_pressed("my_confirm"):
		_on_confirm_button_pressed()
	if event.is_action_pressed("my_universal"):
		if game:
			game.on_universal_input()

#############
# listeners #
#############

func _on_left_button_pressed() -> void:
	if game:
		game.cycle_level_prev()

func _on_right_button_pressed() -> void:
	if game:
		game.cycle_level_next()

func _on_pass_button_pressed() -> void:
	if game:
		game.on_turn_passed()

func _on_step_button_pressed() -> void:
	if game:
		game.on_player_dice_roll()

func _on_settings_button_pressed() -> void:
	if music_player:
		music_player.toggle_mute()

func _on_prev_button_pressed() -> void:
	if game:
		game.on_input_prev()

func _on_next_button_pressed() -> void:
	if game:
		game.on_input_next()

func _on_confirm_button_pressed() -> void:
	if game:
		game.on_player_choose_draw()

#############
# publics   #
#############

#############
# functions #
#############

func _show_winner(player_id : int) -> void:
	var message : String = 'The winner is\nplayer no. ' + str(player_id + 1)
	game_over_result_label.text = message
	game_over_layer.visible = true

func _update_level_label(level_num : int) -> void:
	var level_str : String = str(level_num + 1)
	level_label.text = '#' + level_str

func _roll_the_dice(eyes : Array[bool]) -> int:
	var num : int = 0
	for i : int in range(len(eyes)):
		var eye : bool = eyes[i]
		if eye:
			num += 1
			all_eyes[i].texture = ACTIVE_EYE
		else:
			all_eyes[i].texture = INACTIVE_EYE
	number_label.visible = true
	number_label.text = str(num)
	return num
