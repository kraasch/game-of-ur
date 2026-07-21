extends RefCounted
class_name Board

#############
# signals   #
#############

#############
# enums     #
#############

enum BOARD_INFO {DIMENSION, NUM_CELLS_ON_BOARD, NUM_CELLS_OFFSITE}

enum CELL_INFO {PLAYER, EFFECTS, CELL_ID, COORDS}

#############
# constants #
#############

const OFF_CELL : String = '-'

#############
# exports   #
#############

#############
# on-readys #
#############

#############
# variables #
#############

var grid : Array[Array]

var tiles_dict : Dictionary[String, Tile] = {}

var dimension : Vector2i

var num_cells_on_board : int = 0

var num_cells_offsite : int = 0

#############
# build-ins #
#############

func _init(_map_text : String, _cell_types : Dictionary) -> void:
	_map_text = _map_text.to_lower()
	grid = _parse_tiles(_map_text, _cell_types)

#############
# listeners #
#############

#############
# publics   #
#############

### Returns all tiles that have one of the players on them.
func get_piece_locations(player : Player) -> Array[Tile]:
	var locations : Array[Tile] = []
	for key : String in tiles_dict:
		var tile : Tile = tiles_dict[key]
		if tile and tile.get_player() == player:
			locations.append(tile)
	return locations

func get_cell_by_coords(cell_coords : Vector2i) -> Tile:
	var tile : Tile = grid[cell_coords.x][cell_coords.y]
	return tile

func get_cell_by_id(cell_id : String) -> Tile:
	var is_layer_override : bool = false
	var layer : int = -1
	if cell_id == cell_id.to_upper(): # NOTE: if implementing more layers, do it here.
		# is upper case reference.
		layer = 1
		is_layer_override = true
	cell_id = cell_id.to_lower()
	var tile : Tile = tiles_dict[cell_id]
	if is_layer_override:
		tile.layer = layer
	return tile

func set_player_by_coords(cell_coords : Vector2i, player : Player, layer : int = 0) -> void:
	var tile : Tile = grid[cell_coords.x][cell_coords.y]
	if tile:
		tile.set_player(player, layer)

func remove_player_by_coords(cell_coords : Vector2i) -> void:
	var tile : Tile = grid[cell_coords.x][cell_coords.y]
	if tile:
		tile.remove_player()

func set_player_by_id(cell_id : String, player : Player, layer : int = 0) -> void:
	cell_id = cell_id.to_lower()
	var tile : Tile = tiles_dict[cell_id]
	if tile:
		tile.set_player(player, layer)

func remove_player_by_id(cell_id : String) -> void:
	cell_id = cell_id.to_lower()
	var tile : Tile = tiles_dict[cell_id]
	if tile:
		tile.remove_player()

func get_board_info(type : BOARD_INFO) -> Variant:
	match type:
		BOARD_INFO.DIMENSION:
			return dimension
		BOARD_INFO.NUM_CELLS_OFFSITE:
			return num_cells_offsite
		BOARD_INFO.NUM_CELLS_ON_BOARD:
			return num_cells_on_board
	return null

func get_cell_info_by_coords(type : CELL_INFO, cell_coords : Vector2i) -> Variant:
	match type:
		CELL_INFO.PLAYER:
			var tile : Tile = grid[cell_coords.x][cell_coords.y]
			if tile:
				return tile.get_player()
		CELL_INFO.EFFECTS:
			var tile : Tile = grid[cell_coords.x][cell_coords.y]
			if tile:
				return tile.types
		CELL_INFO.CELL_ID:
			var tile : Tile = grid[cell_coords.x][cell_coords.y]
			if tile:
				return tile.node_id
	return null

func get_cell_info_by_id(type : CELL_INFO, cell_id : String) -> Variant:
	match type:
		CELL_INFO.PLAYER:
			var tile : Tile = tiles_dict[cell_id]
			if tile:
				return tile.get_player()
		CELL_INFO.EFFECTS:
			var tile : Tile = tiles_dict[cell_id]
			if tile:
				return tile.types
		CELL_INFO.COORDS:
			var tile : Tile = tiles_dict[cell_id]
			if tile:
				return tile.grid_coords
	return null

#############
# functions #
#############

func _parse_tiles(map_text : String, _cell_types : Dictionary) -> Array[Array]:
	var temp_grid : Array[Array] = []
	var lines : PackedStringArray = map_text.split(Global.NL)
	dimension = Vector2i(len(lines[0]), lines.size())
	for col : int in range(dimension.x):
		var inner : Array = []
		inner.resize(dimension.y)
		temp_grid.append(inner)
	for i : int in range(dimension.y):
		var line : String = lines[i]
		for j : int in range(dimension.x):
			var character : String = line[j]
			if character == OFF_CELL:
				num_cells_offsite += 1
				tiles_dict[Tile.coords_to_id(j, i)] = null
				continue
			var types_for_cell : Array[Tile.TILE_TYPE] = []
			for type_int : int in _cell_types[character]:
				types_for_cell.append(type_int as Tile.TILE_TYPE)
			var tile : Tile = Tile.new(Vector2i(j, i), types_for_cell, character)
			tiles_dict[tile.node_id] = tile
			temp_grid[j][i] = tile
			num_cells_on_board += 1
	return temp_grid
