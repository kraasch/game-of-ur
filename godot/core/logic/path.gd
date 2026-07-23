extends RefCounted
class_name Path

#### Abstraction of a path of tiles as DAG (directed acyclic graph).
## NOTE: A path is possibly branching off and merging back in.

#############
# classes   #
#############

class Candidate:
	var steps_to_go : int = -1
	var node_id : String = ''
	func _init(_node_id : String, _steps : int):
		steps_to_go = _steps
		node_id = _node_id

class NodesDraw:
	var from_node : String = ''
	var to_node : String = ''
	func _init(_from_node : String, _to_node : String) -> void:
		from_node = _from_node
		to_node = _to_node
	func _to_string() -> String:
		return 'HelperDraw(from:' + str(from_node) + ', to:' + str(to_node) + ')'

#############
# signals   #
#############

#############
# enums     #
#############

#############
# constants #
#############

const MAX_RECURSION_I : int = 1000
const NODE_ID_START : String = 'START'
const NODE_ID_END : String = 'END'
const SEPARATOR : String = ','

#############
# exports   #
#############

#############
# on-readys #
#############

#############
# variables #
#############

### The graph's edges.
var edges : Dictionary = {}

# First node in graph.
var node_first : String

# Last node in graph.
var node_last : String

### The player owning this path.
var player : Player

### Number of links which were created.
var link_counter : int = -2

### Recursion depth when walking the graph.
var current_recusion_depth : int = 0

### Recursion error message, in case max recursion was reached.
var recursion_error_msg : String = ''

### A temporary variable with layer info.
var new_layers : Array[int] = []

#############
# build-ins #
#############

func _init(paths : Array[String], _player : Player) -> void:
	player = _player
	_create_start_and_end_edge(paths)
	_create_edges(paths)

#############
# listeners #
#############

#############
# publics   #
#############

func remove_indxes_from_new_layers_arr(indexes : Array[int]) -> void:
	# Mark the ACTUAL removed draw positions, not the first len(indexes) entries.
	# `indexes` are positions into the current draws array (and thus into new_layers,
	# which is kept parallel to it). Using `i` here instead of `indexes[i]` corrupted
	# the layer/draw alignment and mis-assigned layers (only visible on layered levels).
	for index : int in indexes:
		if index >= 0 and index < len(new_layers):
			new_layers[index] = -1
	new_layers = new_layers.filter(func(x): return not x == -1)

func get_layer_for_index(index : int) -> int:
	if not index >= 0 or not index < len(new_layers):
		return 0 # Safe fallback to the base layer if ever out of sync.
	var new_layer : int = new_layers[index]
	return new_layer

func get_inner_graph() -> Array:
	var ids_arr : Array[Array] = to_node_ids_array()
	var result : Array = Path.get_tile_graph(ids_arr)
	return result

static func convert_to_vector(node_id : String) -> Vector3:
	const DOUBLE_PATH_OFFSET : Vector3 = Vector3(0.0, -0.15, 0.0)
	var character : String = node_id
	var add_double_path_offset : bool = false
	if not character == character.to_lower(): # it is a upper character
		character = character.to_lower() # convert to lower character.
		add_double_path_offset = true
	var x : float = character.unicode_at(0) - "a".unicode_at(0)
	var y : float = node_id.substr(1).to_int()
	var result : Vector3 = Vector3(x, 0.0, y)
	if add_double_path_offset:
		result += DOUBLE_PATH_OFFSET
	return result

static func convert_to_vectors(node_id_a : String, node_id_b : String) -> Array[Vector3]:
	var a : Vector3 = convert_to_vector(node_id_a)
	var b : Vector3 = convert_to_vector(node_id_b)
	var result : Array[Vector3] = [a, b]
	return result

# NOTE: optimally, this could be first converted to vector, then arranged into pairs.
static func get_tile_graph(node_ids_arr : Array[Array]) -> Array:
	var result : Array = []
	for node_ids : Array in node_ids_arr:
		var converted_node_ids : Array = []
		var is_first_loop : bool = true
		var last_node_id : String = ''
		for node_id : String in node_ids:
			if is_first_loop:
				last_node_id = node_id
				is_first_loop = false
				continue
			var vecs : Array[Vector3] = convert_to_vectors(last_node_id, node_id)
			converted_node_ids.append(vecs)
			last_node_id = node_id
		result.append(converted_node_ids)
	return result

func to_node_ids_array() -> Array[Array]:
	current_recusion_depth = 0
	recursion_error_msg = ''
	var result: Array[Array] = []
	var incoming : Dictionary = {}
	for from in edges:
		incoming[from] = incoming.get(from, 0)
		for to in edges[from]:
			incoming[to] = incoming.get(to, 0) + 1
	var visited : Dictionary = {}
	for node in incoming:
		if incoming[node] == 0:
			_walk(node, [], result, visited, true)
	for i : int in range(result.size()):
		result[i] = result[i].filter(func(item): return item != "START" and item != "END")
	return result

func _walk(node : String, current : Array, result : Array[Array], visited : Dictionary, is_main : bool) -> void:
	current_recusion_depth += 1
	if current_recusion_depth >= MAX_RECURSION_I:
		recursion_error_msg = 'max reached'
		return
	current.append(node)
	# side branches stop when they reach an already completed node.
	if not is_main and visited.has(node):
		result.append(current.duplicate())
		return
	# main path nodes are always considered known.
	visited[node] = true
	if not edges.has(node):
		result.append(current.duplicate())
		return
	var children : Array = edges[node]
	if children.size() == 1:
		_walk(children[0], current, result, visited, is_main)
		return
	# main continuation.
	_walk(children[0], current.duplicate(), result, visited, is_main)
	# side branches.
	for i in range(1, children.size()):
		_walk(children[i], [node], result, visited, false)
	# once a branch completes, its nodes are now known too.
	for n in current:
		visited[n] = true

func calculate_possible_draws(pips : int, node_ids : Array[String], start_has_piece : bool) -> Array[NodesDraw]:
	var draws : Array[NodesDraw] = []
	new_layers = []
	var helper_dict : Dictionary[String, bool] = {}
	var add_draws = func(from_id : String, to_ids : Array[String]) -> void:
		for to_id : String in to_ids:
			var draw_id : String = from_id + to_id
			if not helper_dict.has(draw_id):
				helper_dict[draw_id] = true
				draws.append(NodesDraw.new(from_id, to_id))
				var is_upper : bool = to_id == to_id.to_upper()
				var layer_num : int = 1 if is_upper else 0
				new_layers.append(layer_num) # NOTE: this needs to be changed for +3 layers.
	if start_has_piece:
		var to_ids : Array[String] = _to_ids_for_from_id(NODE_ID_START, pips)
		add_draws.call(NODE_ID_START, to_ids)
	for from_id : String in node_ids:
		var to_ids : Array[String] = _to_ids_for_from_id(from_id, pips)
		add_draws.call(from_id, to_ids)
	return draws

### Get the list of next tiles.
func next_tiles(node_id : String):
	return edges.get(node_id, [])

#############
# functions #
#############

func _to_ids_for_from_id(node_id : String, pips : int) -> Array[String]:
	var draws : Array[String] = []
	var candidates : Array[Candidate] = [Candidate.new(node_id, pips)]
	while len(candidates) > 0:
		var first_candidate : Candidate = candidates.pop_front()
		if first_candidate.steps_to_go == 0:
			draws.append(first_candidate.node_id)
		elif first_candidate.steps_to_go >= 1:
			if edges.has(first_candidate.node_id):
				var next_candidate_ids : Array = edges[first_candidate.node_id]
				for next_candidate_id : String in next_candidate_ids:
					candidates.append(Candidate.new(next_candidate_id, first_candidate.steps_to_go - 1))
				# Allow jump to END from the last node.
				if first_candidate.steps_to_go == 1 and first_candidate.node_id == node_last:
					draws.append(NODE_ID_END)
		else:
			pass # TODO: implement: break out in order to avoid infinite loops.
	return draws

### Create a link between two tiles.
func _link(node_from : String, node_to : String):
	if !edges.has(node_from):
		edges[node_from] = []
	edges[node_from].append(node_to)
	link_counter += 1

func _create_edges(paths : Array[String]) -> void:
	for path : String in paths:
		var positions : PackedStringArray = path.split(SEPARATOR)
		for i : int in range(positions.size() - 1):
			var node_from : String = positions[i]
			var node_to : String = positions[i + 1]
			_link(node_from, node_to)

# NOTE: takes the first path's first and last node to connect START and END area.
func _create_start_and_end_edge(paths : Array[String]) -> void:
	var path : String = paths[0]
	var positions : PackedStringArray = path.split(SEPARATOR)
	node_first = positions[0]
	node_last = positions[positions.size() - 1]
	_link(NODE_ID_START, node_first)
	_link(node_last, NODE_ID_END)
