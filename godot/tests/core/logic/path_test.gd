# GdUnit generated TestSuite
class_name PathTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source: String = 'res://code+scenes/logic/path.gd'

func test_calculate_possible_draws_from_start_to_end_00() -> void:
	# DEFINE.
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var player = Player.P1
	var path : Path = Path.new(graph, player)
	var pips : int = 8
	var players_tiles : Array[String] = []
	var start_has_piece : bool = true
	var expected : Array[Path.NodesDraw] = [
		Path.NodesDraw.new(Path.NODE_ID_START, Path.NODE_ID_END),
	]
	# EXECUTION.
	var actual : Array[Path.NodesDraw] = path.calculate_possible_draws(pips, players_tiles, start_has_piece)
	# ASSERT.
	assert_that(actual).is_equal(expected)

func test_calculate_possible_draws_to_end_02() -> void:
	# DEFINE.
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var player = Player.P1
	var path : Path = Path.new(graph, player)
	var pips : int = 3
	var players_tiles : Array[String] = ['d1', 'c2']
	var start_has_piece : bool = true
	var expected : Array[Path.NodesDraw] = [
		Path.NodesDraw.new(Path.NODE_ID_START, 'c0'),
		Path.NodesDraw.new('d1', Path.NODE_ID_END),
		Path.NodesDraw.new('c2', Path.NODE_ID_END),
	]
	# EXECUTION.
	var actual : Array[Path.NodesDraw] = path.calculate_possible_draws(pips, players_tiles, start_has_piece)
	# ASSERT.
	assert_that(actual).is_equal(expected)

func test_calculate_possible_draws_to_end_01() -> void:
	# DEFINE.
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var player = Player.P1
	var path : Path = Path.new(graph, player)
	var pips : int = 3
	var players_tiles : Array[String] = ['d1']
	var start_has_piece : bool = true
	var expected : Array[Path.NodesDraw] = [
		Path.NodesDraw.new(Path.NODE_ID_START, 'c0'),
		Path.NodesDraw.new('d1', Path.NODE_ID_END),
	]
	# EXECUTION.
	var actual : Array[Path.NodesDraw] = path.calculate_possible_draws(pips, players_tiles, start_has_piece)
	# ASSERT.
	assert_that(actual).is_equal(expected)

func test_calculate_possible_draws_to_end_00() -> void:
	# DEFINE.
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var player = Player.P1
	var path : Path = Path.new(graph, player)
	var pips : int = 1
	var players_tiles : Array[String] = ['e2']
	var start_has_piece : bool = true
	var expected : Array[Path.NodesDraw] = [
		Path.NodesDraw.new(Path.NODE_ID_START, 'a0'),
		Path.NodesDraw.new('e2', Path.NODE_ID_END),
	]
	# EXECUTION.
	var actual : Array[Path.NodesDraw] = path.calculate_possible_draws(pips, players_tiles, start_has_piece)
	# ASSERT.
	assert_that(actual).is_equal(expected)

func test_calculate_possible_draws_from_start_01() -> void:
	# DEFINE.
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var player = Player.P1
	var path : Path = Path.new(graph, player)
	var pips : int = 5
	var players_tiles : Array[String] = []
	var start_has_piece : bool = true
	var expected : Array[Path.NodesDraw] = [
		Path.NodesDraw.new(Path.NODE_ID_START, 'd1'),
		Path.NodesDraw.new(Path.NODE_ID_START, 'c2'),
	]
	# EXECUTION.
	var actual : Array[Path.NodesDraw] = path.calculate_possible_draws(pips, players_tiles, start_has_piece)
	# ASSERT.
	assert_that(actual).is_equal(expected)

func test_calculate_possible_draws_from_start_00() -> void:
	# DEFINE.
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var player = Player.P1
	var path : Path = Path.new(graph, player)
	var pips : int = 1
	var players_tiles : Array[String] = []
	var start_has_piece : bool = true
	var expected : Array[Path.NodesDraw] = [
		Path.NodesDraw.new(Path.NODE_ID_START, 'a0'),
	]
	# EXECUTION.
	var actual : Array[Path.NodesDraw] = path.calculate_possible_draws(pips, players_tiles, start_has_piece)
	# ASSERT.
	assert_that(actual).is_equal(expected)

func test_calculate_possible_draws_04() -> void:
	# DEFINE.
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var player = Player.P1
	var path : Path = Path.new(graph, player)
	var pips : int = 5
	var players_tiles : Array[String] = ['b0']
	var start_has_piece : bool = false
	var expected : Array[Path.NodesDraw] = [
		Path.NodesDraw.new('b0', 'e2'),
	]
	# EXECUTION.
	var actual : Array[Path.NodesDraw] = path.calculate_possible_draws(pips, players_tiles, start_has_piece)
	# ASSERT.
	assert_that(actual).is_equal(expected)

func test_calculate_possible_draws_03() -> void:
	# DEFINE.
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var player = Player.P1
	var path : Path = Path.new(graph, player)
	var pips : int = 4
	var players_tiles : Array[String] = ['c0']
	var start_has_piece : bool = false
	var expected : Array[Path.NodesDraw] = [
		Path.NodesDraw.new('c0', 'e2'),
	]
	# EXECUTION.
	var actual : Array[Path.NodesDraw] = path.calculate_possible_draws(pips, players_tiles, start_has_piece)
	# ASSERT.
	assert_that(actual).is_equal(expected)

func test_calculate_possible_draws_02() -> void:
	# DEFINE.
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var player = Player.P1
	var path : Path = Path.new(graph, player)
	var pips : int = 1
	var players_tiles : Array[String] = ['c0']
	var start_has_piece : bool = false
	var expected : Array[Path.NodesDraw] = [
		Path.NodesDraw.new('c0', 'd0'),
		Path.NodesDraw.new('c0', 'c1'),
	]
	# EXECUTION.
	var actual : Array[Path.NodesDraw] = path.calculate_possible_draws(pips, players_tiles, start_has_piece)
	# ASSERT.
	assert_that(actual).is_equal(expected)

func test_calculate_possible_draws_01() -> void:
	# DEFINE.
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var player = Player.P1
	var path : Path = Path.new(graph, player)
	var pips : int = 2
	var players_tiles : Array[String] = ['a0']
	var start_has_piece : bool = false
	var expected : Array[Path.NodesDraw] = [
		Path.NodesDraw.new('a0', 'c0'),
	]
	# EXECUTION.
	var actual : Array[Path.NodesDraw] = path.calculate_possible_draws(pips, players_tiles, start_has_piece)
	# ASSERT.
	assert_that(actual).is_equal(expected)

func test_calculate_possible_draws_00() -> void:
	# DEFINE.
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var player = Player.P1
	var path : Path = Path.new(graph, player)
	var pips : int = 1
	var players_tiles : Array[String] = ['a0']
	var start_has_piece : bool = false
	var expected : Array[Path.NodesDraw] = [
		Path.NodesDraw.new('a0', 'b0'),
	]
	# EXECUTION.
	var actual : Array[Path.NodesDraw] = path.calculate_possible_draws(pips, players_tiles, start_has_piece)
	# ASSERT.
	assert_that(actual).is_equal(expected)

func test_calculate_possible_draws_empty_no_tiles() -> void:
	# DEFINE.
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var player = Player.P1
	var path : Path = Path.new(graph, player)
	var pips : int = 1
	var players_tiles : Array[String] = []
	var start_has_piece : bool = false
	# EXECUTION.
	var actual : Array[Path.NodesDraw] = path.calculate_possible_draws(pips, players_tiles, start_has_piece)
	# ASSERT.
	assert_array(actual).is_empty()

func test_new_path() -> void:
	var graph : Array[String] = [
				'a0,b0,c0,d0,d1,d2,e2',
					  'c0,c1,c2,d2',
			]
	var path : Path = Path.new(graph, Player.P1)
	assert_that(path.link_counter).is_equal(9)
	assert_array(path.next_tiles('a0')).is_equal(['b0'])
	assert_array(path.next_tiles('c0')).is_equal(['d0','c1'])
	assert_array(path.next_tiles('c2')).is_equal(['d2'])
	assert_array(path.next_tiles('d2')).is_equal(['e2'])
	collect_orphan_node_details()
