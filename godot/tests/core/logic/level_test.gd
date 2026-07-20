# GdUnit generated TestSuite
class_name LevelTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source: String = 'res://code+scenes/logic/level.gd'

const NL : String = Global.NL

func test_execute_draw_03() -> void:
	# DEFINE.
	var player : Player = Player.P4
	var enemy_player : Player = Player.P1
	var level : Level = Level.create(Level.LEVEL.LVL7)
	var pips : int = 4
	level.override_tiles_player_by_id('c0', player)
	level.override_tiles_player_by_id('a2', enemy_player)
	level.override_tiles_player_by_id('c1', player)
	var draws : Array[Draw] = level.get_draws(pips, player)
	var meta : Array[Draw.DRAW_TYPE] = Level.get_draws_meta(draws, player)
	var expected_draws : Array[Draw] = [
		Draw.new(player.start, level.get_tile_by_id('b0')),
		Draw.new(player.start, level.get_tile_by_id('c1')),
		Draw.new(level.get_tile_by_id('c0'), level.get_tile_by_id('a2')),
		Draw.new(level.get_tile_by_id('c1'), player.end),
	]
	var expected_meta : Array[Draw.DRAW_TYPE] = [
		Draw.DRAW_TYPE.MOVE_TO_EMPTY,
		Draw.DRAW_TYPE.OCCUPIED,
		Draw.DRAW_TYPE.CAPTURE,
		Draw.DRAW_TYPE.MOVE_TO_END,
	]
	var expected : Dictionary = {
			Level.DRAW_INFO.TYPE : Draw.DRAW_TYPE.OCCUPIED,
			Level.DRAW_INFO.OK   : false,
			Level.DRAW_INFO.DATA : draws[1],
			Level.DRAW_INFO.REPEAT : true,
		}
	# EXECUTE.
	assert_array(draws).is_equal(expected_draws)
	assert_array(meta).is_equal(expected_meta)
	var actual : Dictionary = level.execute_draw(draws[1], player)
	# ASSERT.
	assert_dict(actual).is_equal(expected)
	collect_orphan_node_details()

func test_execute_draw_02() -> void:
	# DEFINE.
	var player : Player = Player.P4
	var enemy_player : Player = Player.P1
	var level : Level = Level.create(Level.LEVEL.LVL7)
	var pips : int = 4
	level.override_tiles_player_by_id('c0', player)
	level.override_tiles_player_by_id('a2', enemy_player)
	level.override_tiles_player_by_id('c1', player)
	var draws : Array[Draw] = level.get_draws(pips, player)
	var meta : Array[Draw.DRAW_TYPE] = Level.get_draws_meta(draws, player)
	var expected_draws : Array[Draw] = [
		Draw.new(player.start, level.get_tile_by_id('b0')),
		Draw.new(player.start, level.get_tile_by_id('c1')),
		Draw.new(level.get_tile_by_id('c0'), level.get_tile_by_id('a2')),
		Draw.new(level.get_tile_by_id('c1'), player.end),
	]
	var expected_meta : Array[Draw.DRAW_TYPE] = [
		Draw.DRAW_TYPE.MOVE_TO_EMPTY,
		Draw.DRAW_TYPE.OCCUPIED,
		Draw.DRAW_TYPE.CAPTURE,
		Draw.DRAW_TYPE.MOVE_TO_END,
	]
	var expected : Dictionary = {
			Level.DRAW_INFO.TYPE : Draw.DRAW_TYPE.MOVE_TO_END,
			Level.DRAW_INFO.OK   : true,
			Level.DRAW_INFO.DATA : draws[3],
			Level.DRAW_INFO.REPEAT : false,
		}
	# EXECUTE.
	assert_array(draws).is_equal(expected_draws)
	assert_array(meta).is_equal(expected_meta)
	var actual : Dictionary = level.execute_draw(draws[3], player)
	# ASSERT.
	assert_dict(actual).is_equal(expected)
	collect_orphan_node_details()

func test_execute_draw_01() -> void:
	# DEFINE.
	var player : Player = Player.P4
	var enemy_player : Player = Player.P1
	var level : Level = Level.create(Level.LEVEL.LVL7)
	var pips : int = 4
	level.override_tiles_player_by_id('c0', player)
	level.override_tiles_player_by_id('a2', enemy_player)
	level.override_tiles_player_by_id('c1', player)
	var draws : Array[Draw] = level.get_draws(pips, player)
	var meta : Array[Draw.DRAW_TYPE] = Level.get_draws_meta(draws, player)
	# EFFECTS .. ROUTE ...... MOVES
	# ........... VV ........ PIPS=4 
	# 12121 .... ##P##<=START 01P00
	# -131- .... -#P#- ...... -020-
	# 12121 END=>E#### ......430000
	# ........... AA ........ MOVES=4
	var expected_draws : Array[Draw] = [
		Draw.new(player.start, level.get_tile_by_id('b0')),
		Draw.new(player.start, level.get_tile_by_id('c1')),
		Draw.new(level.get_tile_by_id('c0'), level.get_tile_by_id('a2')),
		Draw.new(level.get_tile_by_id('c1'), player.end),
	]
	var expected_meta : Array[Draw.DRAW_TYPE] = [
		Draw.DRAW_TYPE.MOVE_TO_EMPTY,
		Draw.DRAW_TYPE.OCCUPIED,
		Draw.DRAW_TYPE.CAPTURE,
		Draw.DRAW_TYPE.MOVE_TO_END,
	]
	var expected : Dictionary = {
			Level.DRAW_INFO.TYPE : Draw.DRAW_TYPE.MOVE_TO_EMPTY,
			Level.DRAW_INFO.OK   : true,
			Level.DRAW_INFO.DATA : draws[0],
			Level.DRAW_INFO.REPEAT : true,
		}
	# EXECUTE
	assert_array(draws).is_equal(expected_draws)
	assert_array(meta).is_equal(expected_meta)
	var actual : Dictionary = level.execute_draw(draws[0], player)
	# ASSERT.
	assert_dict(actual).is_equal(expected)
	collect_orphan_node_details()

func test_execute_draw_00() -> void:
	# DEFINE.
	var player : Player = Player.P4
	var enemy_player : Player = Player.P1
	var level : Level = Level.create(Level.LEVEL.LVL7)
	var pips : int = 4
	level.override_tiles_player_by_id('c0', player)
	level.override_tiles_player_by_id('a2', enemy_player)
	level.override_tiles_player_by_id('c1', player)
	var draws : Array[Draw] = level.get_draws(pips, player)
	var meta : Array[Draw.DRAW_TYPE] = Level.get_draws_meta(draws, player)
	var expected_draws : Array[Draw] = [
		Draw.new(player.start, level.get_tile_by_id('b0')),
		Draw.new(player.start, level.get_tile_by_id('c1')),
		Draw.new(level.get_tile_by_id('c0'), level.get_tile_by_id('a2')),
		Draw.new(level.get_tile_by_id('c1'), player.end),
	]
	var expected_meta : Array[Draw.DRAW_TYPE] = [
		Draw.DRAW_TYPE.MOVE_TO_EMPTY,
		Draw.DRAW_TYPE.OCCUPIED,
		Draw.DRAW_TYPE.CAPTURE,
		Draw.DRAW_TYPE.MOVE_TO_END,
	]
	var expected : Dictionary = {
			Level.DRAW_INFO.TYPE : Draw.DRAW_TYPE.CAPTURE,
			Level.DRAW_INFO.OK   : true,
			Level.DRAW_INFO.DATA : Player.P1,
			Level.DRAW_INFO.REPEAT : false,
		}
	# EXECUTE.
	assert_array(draws).is_equal(expected_draws)
	assert_array(meta).is_equal(expected_meta)
	var actual : Dictionary = level.execute_draw(draws[2], player)
	# ASSERT.
	assert_dict(actual).is_equal(expected)
	collect_orphan_node_details()

func test_get_draws_meta() -> void:
	# DEFINE.
	var player : Player = Player.P4
	var enemy_player : Player = Player.P1
	var level : Level = Level.create(Level.LEVEL.LVL7)
	var pips : int = 4
	var expected_draws : Array[Draw] = [
		Draw.new(player.start, level.get_tile_by_id('b0')),
		Draw.new(player.start, level.get_tile_by_id('c1')),
		Draw.new(level.get_tile_by_id('c0'), level.get_tile_by_id('a2')),
		Draw.new(level.get_tile_by_id('c1'), player.end),
	]
	var expected_meta : Array[Draw.DRAW_TYPE] = [
		Draw.DRAW_TYPE.MOVE_TO_EMPTY,
		Draw.DRAW_TYPE.OCCUPIED,
		Draw.DRAW_TYPE.CAPTURE,
		Draw.DRAW_TYPE.MOVE_TO_END,
	]
	# EXECUTE.
	level.override_tiles_player_by_id('c0', player)
	level.override_tiles_player_by_id('a2', enemy_player)
	level.override_tiles_player_by_id('c1', player)
	var actual_draws : Array[Draw] = level.get_draws(pips, player)
	assert_array(actual_draws).is_equal(expected_draws)
	var actual_meta : Array[Draw.DRAW_TYPE] = Level.get_draws_meta(actual_draws, player)
	assert_array(actual_meta).is_equal(expected_meta)
	# ASSERT.
	collect_orphan_node_details()

func test_override_tiles_player_by_coords() -> void:
	# DEFINE.
	var player : Player = Player.P4
	var level : Level = Level.create(Level.LEVEL.LVL7)
	var pips : int = 4
	var expected : Array[Draw] = [
		Draw.new(player.start, level.get_tile_by_id('b0')),
		Draw.new(player.start, level.get_tile_by_id('c1')),
		Draw.new(level.get_tile_by_id('c0'), level.get_tile_by_id('a2')),
	]
	# EXECUTE.
	level.override_tiles_player_by_coords(Vector2i(2, 0), player)
	var actual : Array[Draw] = level.get_draws(pips, player)
	# ASSERT.
	assert_array(actual).is_equal(expected)
	collect_orphan_node_details()

func test_override_tiles_player_by_id() -> void:
	# DEFINE.
	var player : Player = Player.P4
	var level : Level = Level.create(Level.LEVEL.LVL7)
	var pips : int = 4
	var expected : Array[Draw] = [
		Draw.new(player.start, level.get_tile_by_id('b0')),
		Draw.new(player.start, level.get_tile_by_id('c1')),
		Draw.new(level.get_tile_by_id('c0'), level.get_tile_by_id('a2')),
	]
	# EXECUTE.
	level.override_tiles_player_by_id('c0', player)
	var actual : Array[Draw] = level.get_draws(pips, player)
	# ASSERT.
	assert_array(actual).is_equal(expected)
	collect_orphan_node_details()

func test_get_draws_01() -> void:
	# DEFINE.
	var player : Player = Player.P4
	var level : Level = Level.create(Level.LEVEL.LVL7)
	var pips : int = 4
	var expected : Array[Draw] = [
		Draw.new(player.start, level.get_tile_by_id('b0')),
		Draw.new(player.start, level.get_tile_by_id('c1')),
	]
	# EXECUTE.
	var actual : Array[Draw] = level.get_draws(pips, player)
	# ASSERT.
	assert_array(actual).is_equal(expected)
	collect_orphan_node_details()

func test_draws_00() -> void:
	# DEFINE.
	var player : Player = Player.P1
	var level : Level = Level.create(Level.LEVEL.LVL3)
	var pips : int = 6
	var expected : Array[Draw] = [
		Draw.new(player.start, level.get_tile_by_coords(Vector2i(1, 1))),
	]
	# EXECUTE.
	var actual : Array[Draw] = level.get_draws(pips, player)
	# ASSERT.
	assert_array(actual).is_equal(expected)
	collect_orphan_node_details()

func test_get_piece_locations_intially_empty() -> void:
	for player : Player in Player.PLAYERS:
		for level : Level in Level.create_all_levels():
			var actual : Array[Tile] = level.get_piece_locations(player)
			assert_array(actual).is_empty()
	collect_orphan_node_details()

func test_get_piece_locations() -> void:
	# DEFINE.
	var player : Player = Player.P1
	var level : Level = Level.create(Level.LEVEL.LVL3)
	var coords : Array[Vector2i] = [
		Vector2i(0, 0),
		Vector2i(1, 1),
		Vector2i(3, 1),
	]
	var expected : Array[Tile] = [
		level.get_tile_by_coords(coords[0]),
		level.get_tile_by_coords(coords[1]),
		level.get_tile_by_coords(coords[2]),
	]
	# EXECUTE and ASSERT.
	for coord : Vector2i in coords:
		var tile : Tile = level.get_tile_by_coords(coord)
		assert_that(tile.occupying_player).is_null()
	for coord : Vector2i in coords:
		var tile : Tile = level.get_tile_by_coords(coord)
		tile.occupying_player = player
	var actual : Array[Tile] = level.get_piece_locations(player)
	assert_array(actual).is_equal(expected)
	collect_orphan_node_details()

func test_define_board_cells() -> void:
	# DEFINE.
	var map : String = 	'2111--21' + NL + \
						'11131111' + NL + \
						'2111--21'
	var cell_types : Dictionary = {
			'1' : [Tile.TILE_TYPE.REGULAR],
			'2' : [Tile.TILE_TYPE.REPEAT],
			'3' : [
				Tile.TILE_TYPE.REPEAT,
				Tile.TILE_TYPE.SAFEZONE
			],
		}
	var paths : Array = [
			['d0,c0,b0,a0,a1,b1,c1,d1,e1,f1,g1,h1,h0,g0'],
			['d2,c2,b2,a2,a1,b1,c1,d1,e1,f1,g1,h1,h2,g2'],
		]
	# EXECUTE and ASSERT.
	var level : Level = auto_free(Level.new(map, cell_types, paths))
	assert_int(level._get_num_active_tiles()).is_equal(20)
	assert_int(level._get_num_inactive_tiles()).is_equal(4)
	var tile : Tile = level.get_tile_by_coords(Vector2i(0, 0))
	assert_that(tile is Tile).is_true()
	var offsite : Tile = level.get_tile_by_id('e0')
	assert_that(offsite).is_null()
	collect_orphan_node_details()
