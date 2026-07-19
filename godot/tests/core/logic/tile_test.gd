# GdUnit generated TestSuite
class_name TileTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source: String = 'res://code+scenes/logic/tile.gd'

func test_new_tile() -> void:
	var tile_types : Array[Tile.TILE_TYPE] = [
			Tile.TILE_TYPE.REPEAT,
			Tile.TILE_TYPE.SAFEZONE
		]
	var tile : Tile = Tile.new(Vector2i(2, 3), tile_types)
	assert_vector(tile.grid_coords).is_equal(Vector2i(2, 3))
	assert_array(tile.types).is_equal(tile_types)
	assert_str(tile.node_id).is_equal('c3')
	collect_orphan_node_details()
