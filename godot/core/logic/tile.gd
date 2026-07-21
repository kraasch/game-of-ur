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

### A tile can be occupied by one player's piece at a time or none.
### If occupied, the occupation can be on layer 0 (default) or higher (for different paths).
var player : Player = null

### Layer of tile (to represent different paths on the same tile).
var layer : int = 0

#############
# build-ins #
#############

func _to_string() -> String:
	var p_string : String = ''
	if player:
		p_string = str(player.id)
	return 'Tile(node_id:' + str(node_id) + ', player:' + str(p_string) + ', layer:' + str(layer) + ')'

func _init(_grid_coords : Vector2i, _types : Array[TILE_TYPE], _style_id : String = '0', _layer : int = 0) -> void:
	style_id = _style_id
	grid_coords = _grid_coords
	node_id = coords_to_id(_grid_coords.x, _grid_coords.y)
	types = _types
	layer = _layer

#############
# listeners #
#############

#############
# publics   #
#############

func set_player(_player : Player, _layer : int) -> void:
	player = _player
	layer = _layer

func remove_player() -> void:
	player = null

func get_player() -> Player:
	return player

static func coords_to_id(x : int, y : int) -> String:
	var letter : String = char('a'.unicode_at(0) + x)
	var _node_id : String = letter + str(y)
	return _node_id

#############
# functions #
#############
