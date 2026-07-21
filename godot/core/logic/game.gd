extends RefCounted
class_name  Game

#############
# classes   #
#############

#############
# signals   #
#############

signal change_navigation_visibility(is_show : bool)
signal change_left_right_visibility(is_show : bool)
signal change_right_visibility(is_show : bool)
signal change_left_visibility(is_show : bool)
signal level_changed(level_num : int)
signal player_changed(pid : int)
signal winner_is(pid : int)
signal freeze_dice()
signal unfreeze_dice()
signal freeze_pass_turn()
signal unfreeze_pass_turn()
signal reset_dice()
signal was_dice_roll(rolls : Array[bool])
signal draw_arc(draw : Draw, color : Color)
signal delete_arc()

#############
# enums     #
#############

enum GameState {
	WAITING_FOR_DICE_ROLL,
	WAITING_FOR_TILE_CHOICE,
	WAITING_FOR_PASS,
	RESOLVING_TURN,
	GAME_OVER,
}
enum FOCUS_SHIFT {LEFT, RIGHT}

#############
# constants #
#############

const STATE_STRINGS : Array[String] = [
	'WAITING_FOR_DICE_ROLL',
	'WAITING_FOR_TILE_CHOICE',
	'WAITING_FOR_PASS',
	'RESOLVING_TURN',
	'GAME_OVER',
]
const INITIAL_DRAWS : int = 7

#############
# exports   #
#############

#############
# on-readys #
#############

#############
# varaibles #
#############

### Random number generator.
static var rng : RandomNumberGenerator = RandomNumberGenerator.new()

### Level currently displayed.
static var level : Level

### Level currently displayed.
static var level_index : int = 0

### Connects the game to the visuals: scene for a tile.
### FIELD <==> TILE (visual vs core).
static var field_scene : PackedScene

### Connects the game to the visuals: scene for each of the player's areas.
### FINAL <==> AREA (visual vs core).
static var final_scene : PackedScene

### Fast lookups for areas (to finals) and tiles (to fields).
# NOTE: type would be mixed, eg something like this [Tile, Field] and [Area, Final].
static var fast_lookup : Dictionary [Variant, Variant] = {}

### Connects the game to the visuals: container for instantiated nodes.
static var container : Node3D

### Center of map.
static var map_center : Vector3

### Calculated center of each board.
static var board_center : Vector3 = Vector3.ZERO

### Current player's ID (player ID = PID).
static var current_pid : int

### Game's state.
var state : GameState = GameState.GAME_OVER

### If last draw was a repeat tile or not.
var hit_repeat_tile : bool = false

### Currently focussed draw on the visual board.
var current_focus : Draw

### List of old draws to remove hightlighting fast.
var current_draws : Array[Draw] = []

#############
# build-ins #
#############

#############
# listeners #
#############

func on_player_choose_draw() -> void:
	if not state == GameState.WAITING_FOR_TILE_CHOICE:
		return
	_set_game_state(GameState.RESOLVING_TURN)
	_deal_with_player_choice(current_focus)

func on_turn_passed() -> void:
	if not state == GameState.WAITING_FOR_PASS:
		return
	_set_game_state(GameState.RESOLVING_TURN)
	_deal_with_turn_passed()

func on_player_dice_roll() -> void:
	if not state == GameState.WAITING_FOR_DICE_ROLL:
		return
	_set_game_state(GameState.RESOLVING_TURN)
	var rolls : Array[bool] = get_random_numbers()
	if len(rolls) > 0:
		was_dice_roll.emit(rolls)
	var pips : int = 0
	for roll : bool in rolls:
		if roll:
			pips += 1
	_deal_with_dice_roll(pips)

func on_start_a_new_game() -> void:
	if not state == GameState.GAME_OVER:
		return
	_set_game_state(GameState.RESOLVING_TURN)
	_reset_level()

func on_input_prev() -> void:
	if not state == GameState.WAITING_FOR_TILE_CHOICE:
		return
	_shift_focus(FOCUS_SHIFT.LEFT)

func on_input_next() -> void:
	if not state == GameState.WAITING_FOR_TILE_CHOICE:
		return
	_shift_focus(FOCUS_SHIFT.RIGHT)

func on_universal_input() -> void:
	match state:
		GameState.WAITING_FOR_TILE_CHOICE:
			on_player_choose_draw()
			return
		GameState.WAITING_FOR_DICE_ROLL:
			on_player_dice_roll()
			return
		GameState.WAITING_FOR_PASS:
			on_turn_passed()
			return

#############
# publics   #
#############

func connect_game(
			_field_scene : PackedScene,
			_final_scene : PackedScene,
			_container : Node3D,
			_map_center : Vector3,
		) -> void:
	field_scene = _field_scene
	final_scene = _final_scene
	container = _container
	map_center = _map_center
	_reset_level()

func cycle_level_prev() -> void:
	var number_of_levels : int = len(Level.LEVEL.values())
	level_index = (level_index - 1 + number_of_levels) % number_of_levels
	_reset_level()

func cycle_level_next() -> void:
	var number_of_levels : int = len(Level.LEVEL.values())
	level_index = (level_index + 1 + number_of_levels) % number_of_levels
	_reset_level()

#############
# functions #
#############

func get_tile_graph() -> Array[Array]: # NOTE: actual type is Array[Array[Vector3]]
	return level.get_tile_graph()

func _deal_with_dice_roll(pips : int) -> void:
	if pips == 0:
		_set_game_state(GameState.WAITING_FOR_PASS)
		freeze_dice.emit()
		unfreeze_pass_turn.emit()
		change_navigation_visibility.emit(false)
		return
	_set_game_state(GameState.WAITING_FOR_TILE_CHOICE)
	change_navigation_visibility.emit(true)
	freeze_dice.emit()
	_display_choosable_tiles(pips, Player.PLAYERS[current_pid])

func _deal_with_turn_passed() -> void:
	reset_dice.emit()
	freeze_pass_turn.emit()
	_set_game_state(GameState.WAITING_FOR_DICE_ROLL)
	change_navigation_visibility.emit(false)
	unfreeze_dice.emit()
	_cycle_player_next()

func _deal_with_player_choice(draw : Draw) -> void:
	reset_dice.emit()
	if not draw:
		printerr('error: chosen draw was empty. not good!')
		return
	_set_game_state(GameState.RESOLVING_TURN)
	change_navigation_visibility.emit(false)
	if current_draws:
		_remove_old_hightlights(current_draws)
	_execute_draw(draw)
	_redraw_pieces()
	if not level.someone_won():
		if not hit_repeat_tile:
			_cycle_player_next()
		hit_repeat_tile = false
		_set_game_state(GameState.WAITING_FOR_DICE_ROLL)
		unfreeze_dice.emit()
	else:
		_set_game_state(GameState.GAME_OVER)
		change_navigation_visibility.emit(false)
		winner_is.emit(current_pid)

func _display_choosable_tiles(pips : int, player : Player) -> void:
	var draws : Array[Draw] = level.get_draws(pips, player)
	draws = Level.remove_draws_onto_same_player(draws, player)
	draws = Level.remove_draws_onto_enemy_occupied_safezone_tiles(draws, player)
	if len(draws) == 0:
		change_left_visibility.emit(false)
		_set_game_state(GameState.WAITING_FOR_PASS)
		freeze_dice.emit()
		unfreeze_pass_turn.emit()
		change_navigation_visibility.emit(false)
		return
	if len(draws) == 1:
		change_left_right_visibility.emit(false)
	_highlight_possible_draws(draws)
	current_draws = draws
	_update_focus(0, player.color)

func _update_focus(index : int, color : Color = Color.WHITE_SMOKE) -> void:
	change_left_visibility.emit(not index == 0)
	change_right_visibility.emit(not index == len(current_draws) - 1)
	_remove_focus()
	var new_draw : Draw = current_draws[index]
	current_focus = new_draw
	draw_arc.emit(new_draw, color)
	_set_focus()

func _remove_old_hightlights(draws : Array[Draw]) -> void:
	delete_arc.emit()
	for draw : Draw in draws:
		var to_loc : Location = draw.to
		var from_loc : Location = draw.from
		var to : Variant = fast_lookup[to_loc]
		var from : Variant = fast_lookup[from_loc]
		if from is Final or from is Field:
			from.glow.reset_glow()
			from.glow.reset_focus()
		if to is Final or to is Field:
			to.glow.reset_glow()
			to.glow.reset_focus()

func _highlight_possible_draws(draws : Array[Draw]) -> void:
	for draw : Draw in draws:
		var to_loc : Location = draw.to
		var from_loc : Location = draw.from
		var to : Variant = fast_lookup[to_loc]
		var from : Variant = fast_lookup[from_loc]
		if from is Final or from is Field:
			from.glow.enable_glow()
		if to is Final or to is Field:
			to.glow.enable_glow()

func _set_focus() -> void:
	var draw : Draw = current_focus
	var to_loc : Location = draw.to
	var from_loc : Location = draw.from
	var to : Variant = fast_lookup[to_loc]
	var from : Variant = fast_lookup[from_loc]
	if from is Final or from is Field:
		(from.glow as Glow).set_focus()
	if to is Final or to is Field:
		(to.glow as Glow).set_focus()

func _remove_focus() -> void:
	# TODO: buggy, if playing one turn on one board then switching and playing another.
	# Invalid access to property or key 'Tile(node_id:a2, style:3)' on a base 
	# object of type 'Dictionary'.
	# NOTE: also buggy after won games.
	if not current_focus:
		return
	var draw : Draw = current_focus
	var to_loc : Location = draw.to
	var from_loc : Location = draw.from
	if fast_lookup.has(to_loc):
		var to : Variant = fast_lookup[to_loc] # TODO: bug here.
		if to is Final or to is Field:
			(to.glow as Glow).reset_focus()
	if fast_lookup.has(from_loc):
		var from : Variant = fast_lookup[from_loc] # TODO: bug here.
		if from is Final or from is Field:
			(from.glow as Glow).reset_focus()

func _shift_focus(focus_shift : FOCUS_SHIFT) -> void: # TODO: refine.
	if current_draws.size() <= 1:
		return
	var draw : Draw = current_focus
	var index : int = current_draws.find(draw)
	var next_index : int = clamp(
		index + (1 if focus_shift == FOCUS_SHIFT.RIGHT else -1),
		0,
		current_draws.size() - 1
	)
	_update_focus(next_index, Player.PLAYERS[current_pid].color)

func _execute_draw(draw : Draw) -> void:
	var info : Dictionary = level.do_execute_draw(draw, Player.PLAYERS[current_pid])
	var output : Variant = info[Level.DRAW_INFO.REPEAT]
	if output is bool:
		var is_repeat : bool = output as bool
		hit_repeat_tile = is_repeat

func _redraw_pieces() -> void: # TODO: validate.
	var all_locations : Array[Tile] = []
	for p : Player in level.players:
		var piece_locations : Array[Tile] = level.get_piece_locations(p)
		all_locations.append_array(piece_locations)
		for tile : Tile in piece_locations:
			var field : Field = fast_lookup[tile] as Field
			field.show_piece_of_player(p)
	var tiles_dict : Dictionary = level.board.tiles_dict
	for key in tiles_dict:
		var tile : Tile = tiles_dict[key]
		if not tile in all_locations and fast_lookup.has(tile):
			var field : Field = fast_lookup[tile] as Field
			field.hide_piece()

func get_random_numbers() -> Array[bool]:
	var result : Array[bool] = []
	for i : int in range(4):
		var val : bool = rng.randf() > 0.5
		result.append(val)
	return result

func _reset_level() -> void:
	change_navigation_visibility.emit(false)
	freeze_pass_turn.emit()
	delete_arc.emit()
	hit_repeat_tile = false
	current_draws = []
	state = GameState.GAME_OVER
	level = Level.create(level_index)
	_set_player_id_randomly(level)
	_add_fields_and_finals()
	_set_initial_number_of_draws(INITIAL_DRAWS)
	_set_game_state(GameState.WAITING_FOR_DICE_ROLL)
	unfreeze_dice.emit()
	level_changed.emit(level_index)

func _set_player_id_randomly(_level : Level) -> void:
	var random_id : int = rng.randi_range(0, len(_level.players) - 1)
	_set_player_id(random_id)

func _add_fields_and_finals() -> void:
	fast_lookup = {}
	_load_tiles()
	_setup_finals_for_players(len(level.players))

func _cycle_player_next() -> void:
	_set_player_id((current_pid + 1) % len(level.players))

func _set_player_id(pid : int) -> void:
	current_pid = pid
	player_changed.emit(pid)

func _set_game_state(_state : GameState) -> void: # TODO: turn into state machine?
	print('current state ' + STATE_STRINGS[_state])
	state = _state

###########
# statics #
###########

static func _setup_finals_for_players(players : int) -> void:
	for i : int in range(players):
		var player : Player = Player.PLAYERS[i]
		const MINI_MARGIN : float = 0.1
		const Y_FINAL_START : float = 3.0
		const X_FINAL_START : float = -2.5 - MINI_MARGIN
		const X_FINAL_END : float = 8.5 + MINI_MARGIN
		const GAP_BETWEEN_FINALS : float = 2.0 + MINI_MARGIN
		# TODO: extract method for setting up END or START.
		var final_start : Final = final_scene.instantiate()
		container.add_child(final_start)
		fast_lookup[player.start] = final_start
		final_start.set_color(player.color)
		player.start.content_number_changed.connect(final_start.update_number)
		final_start.global_position = Vector3(X_FINAL_START, 0, Y_FINAL_START + i * -GAP_BETWEEN_FINALS)
		var final_end : Final = final_scene.instantiate()
		container.add_child(final_end)
		fast_lookup[player.end] = final_end
		final_end.set_color(player.color)
		player.end.content_number_changed.connect(final_end.update_number)
		final_end.global_position = Vector3(X_FINAL_END, 0, Y_FINAL_START + i * -GAP_BETWEEN_FINALS)

static func _set_initial_number_of_draws(intial_draws : int) -> void:
	for i : int in range(len(Player.PLAYERS)):
		var player : Player = Player.PLAYERS[i]
		player.start.set_number_of_pieces(intial_draws)
		player.end.set_number_of_pieces(0)

static func _clean_tiles() -> void:
	for node in container.get_children():
		node.queue_free()

static func _get_centering_offset(board_dim: Vector3) -> Vector3:
	var _board_center : Vector3 = Vector3(board_dim.x * 0.5, 0, board_dim.z * 0.5)
	board_center = _board_center
	return get_offset()

static func get_offset() -> Vector3:
	return map_center - board_center 

static func _load_tiles() -> void:
	_clean_tiles()
	var level_dimension : Vector3 = Vector3(level.board.dimension.x, 0, level.board.dimension.y)
	var centering_offset : Vector3 = _get_centering_offset(level_dimension)
	for i: int in range(level.board.dimension.x):
		for j: int in range(level.board.dimension.y):
			var tile : Tile = level.board.grid[i][j]
			if tile:
				var field : Field = field_scene.instantiate()
				var style_id : String = tile.style_id
				container.add_child(field)
				fast_lookup[tile] = field
				if style_id.is_valid_int():
					field.set_surface(style_id.to_int() - 1)
				field.global_position = Vector3(i, 0, j) + centering_offset
