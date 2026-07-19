# GdUnit generated TestSuite
class_name BoardTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source: String = 'res://code+scenes/logic/board.gd'

func test_set_player() -> void:
	var map : String = 	'2111--21' + Global.NL + \
						'11131111' + Global.NL + \
						'2111--21'
	var cell_types : Dictionary = {
			'1' : [Tile.TILE_TYPE.REGULAR],
			'2' : [Tile.TILE_TYPE.REPEAT],
			'3' : [
				Tile.TILE_TYPE.REPEAT,
				Tile.TILE_TYPE.SAFEZONE
			],
		}
	var board : Board = auto_free(Board.new(map, cell_types))
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(0, 0))).is_equal(null)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(1, 1))).is_equal(null)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(3, 1))).is_equal(null)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'a0')).is_equal(null)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'b1')).is_equal(null)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'd1')).is_equal(null)
	board.set_player_by_coords(Vector2i(1, 1), Player.P1)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(0, 0))).is_equal(null)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(1, 1))).is_equal(Player.P1)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(3, 1))).is_equal(null)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'a0')).is_equal(null)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'b1')).is_equal(Player.P1)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'd1')).is_equal(null)
	board.set_player_by_id('b1', Player.P2)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(0, 0))).is_equal(null)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(1, 1))).is_equal(Player.P2)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(3, 1))).is_equal(null)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'a0')).is_equal(null)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'b1')).is_equal(Player.P2)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'd1')).is_equal(null)
	board.set_player_by_id('d1', Player.P3)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(0, 0))).is_equal(null)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(1, 1))).is_equal(Player.P2)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(3, 1))).is_equal(Player.P3)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'a0')).is_equal(null)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'b1')).is_equal(Player.P2)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'd1')).is_equal(Player.P3)
	collect_orphan_node_details()

func test_new_board() -> void:
	var map : String = 	'2111--21' + Global.NL + \
						'11131111' + Global.NL + \
						'2111--21'
	var cell_types : Dictionary = {
			'1' : [Tile.TILE_TYPE.REGULAR],
			'2' : [Tile.TILE_TYPE.REPEAT],
			'3' : [
				Tile.TILE_TYPE.REPEAT,
				Tile.TILE_TYPE.SAFEZONE,
			],
		}
	var board : Board = auto_free(Board.new(map, cell_types))
	assert_vector(board.get_board_info(Board.BOARD_INFO.DIMENSION)).is_equal(Vector2i(8, 3))
	assert_int(board.get_board_info(Board.BOARD_INFO.NUM_CELLS_ON_BOARD)).is_equal(20)
	assert_int(board.get_board_info(Board.BOARD_INFO.NUM_CELLS_OFFSITE)).is_equal(4)
	assert_str(board.get_cell_info_by_coords(Board.CELL_INFO.CELL_ID, Vector2i(0, 0))).is_equal('a0')
	assert_str(board.get_cell_info_by_coords(Board.CELL_INFO.CELL_ID, Vector2i(1, 1))).is_equal('b1')
	assert_str(board.get_cell_info_by_coords(Board.CELL_INFO.CELL_ID, Vector2i(3, 1))).is_equal('d1')
	assert_vector(board.get_cell_info_by_id(Board.CELL_INFO.COORDS, 'a0')).is_equal(Vector2i(0, 0))
	assert_vector(board.get_cell_info_by_id(Board.CELL_INFO.COORDS, 'b1')).is_equal(Vector2i(1, 1))
	assert_vector(board.get_cell_info_by_id(Board.CELL_INFO.COORDS, 'd1')).is_equal(Vector2i(3, 1))
	assert_array(board.get_cell_info_by_coords(Board.CELL_INFO.EFFECTS, Vector2i(0, 0))).is_equal(cell_types['2'])
	assert_array(board.get_cell_info_by_coords(Board.CELL_INFO.EFFECTS, Vector2i(1, 1))).is_equal(cell_types['1'])
	assert_array(board.get_cell_info_by_coords(Board.CELL_INFO.EFFECTS, Vector2i(3, 1))).is_equal(cell_types['3'])
	assert_array(board.get_cell_info_by_id(Board.CELL_INFO.EFFECTS, 'a0')).is_equal(cell_types['2'])
	assert_array(board.get_cell_info_by_id(Board.CELL_INFO.EFFECTS, 'b1')).is_equal(cell_types['1'])
	assert_array(board.get_cell_info_by_id(Board.CELL_INFO.EFFECTS, 'd1')).is_equal(cell_types['3'])
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(0, 0))).is_equal(null)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(1, 1))).is_equal(null)
	assert_that(board.get_cell_info_by_coords(Board.CELL_INFO.PLAYER, Vector2i(3, 1))).is_equal(null)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'a0')).is_equal(null)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'b1')).is_equal(null)
	assert_that(board.get_cell_info_by_id(Board.CELL_INFO.PLAYER, 'd1')).is_equal(null)
	collect_orphan_node_details()
