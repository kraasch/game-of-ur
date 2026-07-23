extends RefCounted
class_name Level

#############
# classes   #
#############

#############
# statics   #
#############

enum LEVEL {LVL1, LVL2, LVL3, LVL4, LVL5, LVL6, LVL7, LVL8}

static var level_creators : Array[Callable] = [
	_create_level_01, _create_level_02, _create_level_03, _create_level_04,
	_create_level_05, _create_level_06, _create_level_07, _create_level_08,
]

static func create(level : LEVEL) -> Level:
	return level_creators[level as int].call()

static func create_all_levels() -> Array[Level]:
	var levels : Array[Level] = []
	for level : LEVEL in LEVEL.values():
		levels.append(Level.create(level))
	return levels

static func _create_level_01() -> Level:
	return Level.new(
		'2111--21' + NL +
		'11131111' + NL +
		'2111--21',
		{
			'1' : [Tile.TILE_TYPE.REGULAR],
			'2' : [Tile.TILE_TYPE.REPEAT],
			'3' : [
				Tile.TILE_TYPE.REPEAT,
				Tile.TILE_TYPE.SAFEZONE
			],
		},
		[
			['d0,c0,b0,a0,a1,b1,c1,d1,e1,f1,g1,h1,h0,g0'],
			['d2,c2,b2,a2,a1,b1,c1,d1,e1,f1,g1,h1,h2,g2'],
		]
	)

static func _create_level_02() -> Level:
	return Level.new(
		'2111--21' + NL +
		'11131111' + NL +
		'2111--21',
		{
			'1' : [Tile.TILE_TYPE.REGULAR],
			'2' : [Tile.TILE_TYPE.REPEAT],
			'3' : [
				Tile.TILE_TYPE.REPEAT,
				Tile.TILE_TYPE.SAFEZONE
			],
		},
		[
			['a0,b0,c0,d0,d1,e1,f1,g1,g0,h0,h1,h2,g2,G1,F1,E1,D1,C1,B1,A1'],
			['a2,b2,c2,d2,d1,e1,f1,g1,g2,h2,h1,h0,g0,G1,F1,E1,D1,C1,B1,A1'],
		]
	)

static func _create_level_03() -> Level:
	return Level.new(
		'1' + NL +
		'2' + NL +
		'3' + NL +
		'2' + NL +
		'1',
		{
			'1' : [Tile.TILE_TYPE.REGULAR],
			'2' : [Tile.TILE_TYPE.REPEAT],
			'3' : [
				Tile.TILE_TYPE.REPEAT,
				Tile.TILE_TYPE.SAFEZONE
			],
		},
		[
			['a0,a1,a2,a3,a4'],
			['a4,a3,a2,a1,a0']
		],
	)

static func _create_level_04() -> Level:
	return Level.new(
		'131' + NL +
		'323' + NL +
		'131',
		{
			'1' : [Tile.TILE_TYPE.REGULAR],
			'2' : [Tile.TILE_TYPE.REPEAT],
			'3' : [Tile.TILE_TYPE.SAFEZONE],
		},
		[
			['a0,a1,b1,c1,c2'],
			['c0,b0,b1,b2,a2'],
			['c2,c1,b1,a1,a0'],
			['a2,b2,b1,b0,c0'],
		]
	)

static func _create_level_05() -> Level:
	return Level.new(
		'1111-' + NL +
		'-1-1-' + NL +
		'-1111',
		{
			'1' : [Tile.TILE_TYPE.REGULAR],
		},
		[
			[
				'a0,b0,c0,d0,d1,d2,e2',
				   'b0,b1,b2,c2,d2',
			],
			[
				'a0,b0,c0,d0,d1,d2,e2',
				   'b0,b1,b2,c2,d2',
			],
		]
	)

static func _create_level_06() -> Level:
	return Level.new(
		'1131-' + NL +
		'-232-' + NL +
		'-1311',
		{
			'1' : [Tile.TILE_TYPE.REGULAR],
			'2' : [Tile.TILE_TYPE.REPEAT],
			'3' : [
				Tile.TILE_TYPE.REPEAT,
				Tile.TILE_TYPE.SAFEZONE
			],
		},
		[
			[
				'a0,b0,c0,d0,d1,d2,e2',
				   'b0,b1,b2,c2',
					  'c0,c1,c2,d2',
			],
			[
				'e2,d2,c2,b2,b1,b0,a0',
				   'd2,d1,d0,c0',
					  'c2,c1,c0,b0',
			],
		]
	)

static func _create_level_07() -> Level:
	return Level.new(
		'12121' + NL +
		'-131-' + NL +
		'12121',
		{
			'1' : [Tile.TILE_TYPE.REGULAR],
			'2' : [Tile.TILE_TYPE.REPEAT],
			'3' : [
				Tile.TILE_TYPE.REPEAT,
				Tile.TILE_TYPE.SAFEZONE
			],
		},
		[
			[
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			],
			[
				'e2,d2,c2,b2,b1,b0,a0',
					  'c2,c1,c0,b0',
			],
			[
				'a2,b2,c2,d2,d1,d0,e0',
					  'c2,c1,c0,d0',
			],
			[
				'e0,d0,c0,b0,b1,b2,a2',
					  'c0,c1,c2,b2',
			],
		]
	)

static func _create_level_08() -> Level:
	return Level.new(
		'21-131-21' + NL +
		'1113-3111' + NL +
		'21-131-21',
		{
			'1' : [Tile.TILE_TYPE.REGULAR],
			'2' : [Tile.TILE_TYPE.REPEAT],
			'3' : [
				Tile.TILE_TYPE.REPEAT,
				Tile.TILE_TYPE.SAFEZONE
			],
		},
		[
			[
				'b0,a0,a1,b1,c1,d1,d0,e0,f0,f1,g1,h1,i1,i0,h0',
							   'd1,d2,e2,f2,f1,g1',
			],
			[
				'b2,a2,a1,b1,c1,d1,d2,e2,f2,f1,g1,h1,i1,i2,h2',
							   'd1,d0,e0,f0,f1,g1'
			],
		]
	)

#############
# signals   #
#############

#############
# enums     #
#############

enum DRAW_INFO {TYPE, OK, DATA, REPEAT}

#############
# constants #
#############

const NL : String = Global.NL

#############
# exports   #
#############

#############
# on-readys #
#############

#############
# variables #
#############

### All tiles in a level.
var board : Board

### All players in a level.
var players : Array[Player] = []

### All players in a level.
var call_type_dict : Dictionary = {}

### Each player's path over the board.
var paths : Array[Path] = []

#############
# build-ins #
#############

func _init(_map_text : String, _cell_types : Dictionary, _graphs_with_branches : Array) -> void:
	board = Board.new(_map_text, _cell_types)
	for i : int in range(len(_graphs_with_branches)):
		var graph : Array[String] = []
		for s : String in _graphs_with_branches[i]:
			graph.append(s)
		var player : Player = Player.int_to_player(i)
		var path : Path = Path.new(graph, player)
		players.append(player)
		paths.append(path)

#############
# listeners #
#############

#############
# publics   #
#############

func someone_won() -> bool:
	var result : bool = false
	for player : Player in players:
		var start : Area = player.start
		var end : Area = player.end
		if Area.is_win_condition(start, end):
			result = true
			break
	return result

static func get_draws_meta(draws : Array[Draw], drawing_player : Player) -> Array[Draw.DRAW_TYPE]:
	var draw_metas : Array[Draw.DRAW_TYPE] = []
	for draw : Draw in draws:
		var type : Draw.DRAW_TYPE = _determine_draw_type(draw, drawing_player)
		draw_metas.append(type)
	return draw_metas

func _do_the_draw(draw : Draw, player : Player, draw_index : int) -> Player:
	var players_path : Path = _get_players_path(player)
	var new_target_layer : int = players_path.get_layer_for_index(draw_index)
	var enemy_player : Player = null
	var to_loc : Location = draw.to
	var from_loc : Location = draw.from
	if to_loc is Tile:
		var to_tile : Tile = to_loc as Tile
		var info : Variant = board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, to_tile.node_id)
		if info is Player:
			var occupying_player : Player = info as Player
			if occupying_player:
				occupying_player.start.increase_number_of_pieces()
				enemy_player = occupying_player
		board.set_player_by_id(to_tile.node_id, player, new_target_layer)
	elif to_loc is Area:
		var to_area : Area = to_loc as Area
		to_area.increase_number_of_pieces()
	if from_loc is Tile:
		var from_tile : Tile = from_loc as Tile
		board.remove_player_by_id(from_tile.node_id)
	elif from_loc is Area:
		var from_area : Area = from_loc as Area
		from_area.decrease_number_of_pieces()
	return enemy_player

func do_execute_draw(draw : Draw, player : Player, draw_index : int) -> Dictionary:
	var enemy : Player = _do_the_draw(draw, player, draw_index) # NOTE: added in after.
	# TODO: is this the function which also updates tiles and areas?
	var type : Draw.DRAW_TYPE = _determine_draw_type(draw, player)
	var repeat_effect : bool = _get_repeat_effect(draw.to)
	var result : Dictionary = {
			Level.DRAW_INFO.TYPE   : type,
			Level.DRAW_INFO.OK     : not type == Draw.DRAW_TYPE.OCCUPIED,
			Level.DRAW_INFO.REPEAT : repeat_effect,
		}
	match type:
		Draw.DRAW_TYPE.CAPTURE:
			result[Level.DRAW_INFO.DATA] = enemy # TODO: this should be the player variable, right?
		Draw.DRAW_TYPE.MOVE_TO_EMPTY, Draw.DRAW_TYPE.MOVE_TO_END, Draw.DRAW_TYPE.OCCUPIED:
			result[Level.DRAW_INFO.DATA] = draw
	return result

# TODO: deprecate and remove.
func preexecute_draw(draw : Draw, player : Player) -> Dictionary:
	# TODO: this entire function was work in progress and never finished.
	var type : Draw.DRAW_TYPE = _determine_draw_type(draw, player)
	var repeat_effect : bool = _get_repeat_effect(draw.to)
	var result : Dictionary = {
			Level.DRAW_INFO.TYPE   : type,
			Level.DRAW_INFO.OK     : not type == Draw.DRAW_TYPE.OCCUPIED,
			Level.DRAW_INFO.REPEAT : repeat_effect,
		}
	match type:
		Draw.DRAW_TYPE.CAPTURE:
			result[Level.DRAW_INFO.DATA] = Player.P1
		Draw.DRAW_TYPE.MOVE_TO_EMPTY, Draw.DRAW_TYPE.MOVE_TO_END, Draw.DRAW_TYPE.OCCUPIED:
			result[Level.DRAW_INFO.DATA] = draw
	return result

func _get_repeat_effect(location : Location) -> bool:
	var repeat_effect : bool = false
	if location is Tile:
		var target_tile : Tile = location as Tile
		var output : Variant = board.get_cell_info_by_id(board.CELL_INFO.EFFECTS, target_tile.node_id)
		var effects : Array[Tile.TILE_TYPE] = output as Array[Tile.TILE_TYPE]
		if effects.has(Tile.TILE_TYPE.REPEAT):
			repeat_effect = true
	return repeat_effect

func override_tiles_player_by_id(node_id : String, player : Player, layer : int = 0) -> void:
	var tile : Tile = get_tile_by_id(node_id)
	if node_id == node_id.to_upper():
		# contains upper characters.
		layer = 1
	tile.set_player(player, layer)

func override_tiles_player_by_coords(coords : Vector2i, player : Player, layer : int = 0) -> void:
	var tile : Tile = get_tile_by_coords(coords)
	tile.set_player(player, layer)

### List all possible draws for a dice roll outcome.
func get_draws(pips : int, player : Player) -> Array[Draw]:
	if not players.has(player):
		return []
	var players_path : Path = _get_players_path(player)
	var players_tiles : Array[Tile] = board.get_piece_locations(player)
	var nodes : Array[String] = _get_node_ids_from_tiles(players_tiles)
	var start_has_piece : bool = player.start.number_of_pieces > 0
	var node_draws : Array[Path.NodesDraw] = players_path.calculate_possible_draws(pips, nodes, start_has_piece)
	var draws : Array[Draw] = _convert_draws_from_nodes_to_tiles(node_draws, player)
	return draws

### Returns all tiles that have one of the players on them.
func get_piece_locations(player : Player) -> Array[Tile]:
	return board.get_piece_locations(player)

func number_of_cells() -> int:
	return 0

func get_tile_by_coords(coords : Vector2i) -> Tile:
	return board.get_cell_by_coords(coords)

func get_tile_by_id(tile_id : String) -> Tile:
	return board.get_cell_by_id(tile_id)

#############
# functions #
#############

static func remove_draws_onto_same_player(draws : Array[Draw], player : Player) -> Array:
	var result : Array[Draw] = []
	var _remove_indexes : Array[int] = []
	for i : int in range(len(draws)):
		var draw : Draw = draws[i]
		var to_loc : Location = draw.to
		if to_loc is Tile:
			var to_tile : Tile = to_loc as Tile
			if not to_tile or to_tile.get_player() == player:
				_remove_indexes.append(i)
				continue
		result.append(draw)
	return [result, _remove_indexes]

static func remove_draws_onto_enemy_occupied_safezone_tiles(draws : Array[Draw], player : Player) -> Array:
	var result : Array[Draw] = []
	var _remove_indexes : Array[int] = []
	for i : int in range(len(draws)):
		var draw : Draw = draws[i]
		var to_loc : Location = draw.to
		if to_loc is Tile:
			var to_tile : Tile = to_loc as Tile
			if to_tile: 
				var enemy : Player = to_tile.get_player()
				var is_not_empty : bool = not enemy == null
				var is_not_self : bool = not enemy == player
				var occupied_by_another : bool = is_not_empty and is_not_self
				var has_protection_effect : bool = to_tile.types.has(Tile.TILE_TYPE.SAFEZONE)
				if occupied_by_another and has_protection_effect:
					_remove_indexes.append(i)
					continue
		result.append(draw)
	return [result, _remove_indexes]

static func _determine_draw_type(draw : Draw, drawing_player : Player) -> Draw.DRAW_TYPE:
	#var _from : Location = draw.from # NOTE: for the future.
	var to : Location = draw.to
	if to is Area:
		return Draw.DRAW_TYPE.MOVE_TO_END
	var to_tile : Tile = to as Tile
	if not to_tile.get_player():
		return Draw.DRAW_TYPE.MOVE_TO_EMPTY
	if to_tile.get_player() == drawing_player:
		return Draw.DRAW_TYPE.OCCUPIED
	if to_tile.get_player() in Player.PLAYERS:
		return Draw.DRAW_TYPE.CAPTURE
	return Draw.DRAW_TYPE.NONE

func _convert_draws_from_nodes_to_tiles(node_draws : Array[Path.NodesDraw], player : Player) -> Array[Draw]:
	var draws : Array[Draw] = []
	for node_draw : Path.NodesDraw in node_draws:
		var from_id : String = node_draw.from_node
		var to_id : String = node_draw.to_node
		var from : Location = player.start
		var to : Location = player.end 
		if not from_id == Path.NODE_ID_START:
			from = board.get_cell_by_id(from_id)
		if not to_id == Path.NODE_ID_END:
			to = board.get_cell_by_id(to_id)
		draws.append(Draw.new(from, to))
	return draws

func _get_node_ids_from_tiles(tiles : Array[Tile]) -> Array[String]:
	var node_ids : Array[String] = []
	for tile : Tile in tiles:
		var current_id : String = tile.node_id
		if tile.layer == 1: # NOTE: add more layers here, if needed.
			current_id = current_id.to_upper()
		node_ids.append(current_id)
	return node_ids

func _get_players_path(player : Player) -> Path:
	var player_id : int = Player.player_to_int(player)
	return paths[player_id]

func _get_num_inactive_tiles() -> int:
	return 4

func _get_num_active_tiles() -> int:
	return 20
