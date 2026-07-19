# GdUnit generated TestSuite
class_name PlayerTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source: String = 'res://code+scenes/logic/player.gd'

func test_get_areas() -> void:
	var player : Player = Player.PLAYERS[0]
	var start : Area = player.get_area(Area.AREA_TYPE.START)
	assert_that(start.type).is_equal(Area.AREA_TYPE.START)
	assert_that(start.number_of_pieces).is_equal(7)
	var end : Area = player.get_area(Area.AREA_TYPE.END)
	assert_that(end.type).is_equal(Area.AREA_TYPE.END)
	assert_that(end.number_of_pieces).is_equal(0)
	collect_orphan_node_details()

func test_get_players() -> void:
	var player : Player = Player.PLAYERS[0]
	assert_that(player).is_equal(Player.P1)
	collect_orphan_node_details()

func test_new_player() -> void:
	var player : Player = Player.new(42, Color.BLUE)
	assert_int(player.id).is_equal(42)
	assert_that(player.color).is_equal(Color.BLUE)
	collect_orphan_node_details()
