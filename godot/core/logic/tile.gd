extends Location
class_name Tile

#############
# signals   #
#############

#############
# enums     #
#############

enum TILE_TYPE {REGULAR, REPEAT, SAFEZONE}

#############
# constants #
#############

#############
# exports   #
#############

#############
# on-readys #
#############

#############
# variables #
#############

### Game-global style ID for this tile.
var style_id : String = '0'

### A tile's node ID for defining paths through tile graph.
var node_id : String = ''

### Each tile has its own effects for the piece that lands on it.
# NOTE some tiles have more than 1 effect, in the traditional game the
# center piece lets the player repeat a turn, but also acts as a safezone.
var types : Array[TILE_TYPE] = []

### The location each piece has within the board.
var grid_coords : Vector2i = Vector2i(0, 0)

### A tile can contain one player's piece at a time or none.
var occupying_player : Player = null

### Each logic tile has an actual 3D representation. # TODO: implement.
#var representation : Node3D

#############
# build-ins #
#############

func _to_string() -> String:
	return 'Tile(node_id:' + str(node_id) + ', style:' + str(style_id) + ')'

func _init(_grid_coords : Vector2i, _types : Array[TILE_TYPE], _style_id : String = '0') -> void:
	style_id = _style_id
	grid_coords = _grid_coords
	node_id = coords_to_id(_grid_coords.x, _grid_coords.y)
	types = _types

#############
# listeners #
#############

#############
# publics   #
#############

static func coords_to_id(x : int, y : int) -> String:
	var letter : String = char('a'.unicode_at(0) + x)
	var _node_id : String = letter + str(y)
	return _node_id

#############
# functions #
#############
