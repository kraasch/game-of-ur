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

#############
# signals   #
#############

#############
# enums     #
#############

#############
# constants #
#############

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

static func convert_to_vectors(node_id : String) -> Array[Vector3]:
	var result : Array[Vector3] = [Vector3(), Vector3()]
	# TODO: implement.
	return result

static func get_tile_graph(node_ids : Array[String]) -> Array:
	var result : Array = []
	for node_id : String in node_ids:
		var vecs : Array[Vector3] = convert_to_vectors(node_id)
		result.append(vecs)
	return result

#func to_tree() -> Array: # TODO: remove.
	#return [
		#[Vector3(1.0, 0.0, 2.0), Vector3(3.0, 0.0, 3.0)],
		#[Vector3(2.0, 0.0, 2.0), Vector3(3.0, 0.0, 3.0)],
	#]

func to_node_ids_array() -> Array[Array]:
	var result: Array[Array] = []
	var incoming := {}
	for from in edges:
		incoming[from] = incoming.get(from, 0)
		for to in edges[from]:
			incoming[to] = incoming.get(to, 0) + 1
	for node in incoming:
		if incoming[node] == 0:
			_walk(node, [], result, incoming, true)
	for i : int in range(len(result)):
		var arr : Array = result[i]
		result[i] = arr.filter(func(item): return item != "START" and item != "END")
	return result
	
func _walk(
	node: String,
	current: Array,
	result: Array[Array],
	incoming: Dictionary,
	is_main: bool
) -> void:
	current.append(node)
	# Stop a side branch when it merges back.
	if !is_main and incoming.get(node, 0) > 1:
		result.append(current.duplicate())
		return
	if !edges.has(node):
		result.append(current.duplicate())
		return
	var children: Array = edges[node]
	if children.size() == 1:
		_walk(children[0], current, result, incoming, is_main)
		return
	# Continue the current path on the first child.
	_walk(children[0], current.duplicate(), result, incoming, is_main)
	# Remaining children are side branches.
	for i in range(1, children.size()):
		_walk(children[i], [node], result, incoming, false)

func calculate_possible_draws(pips : int, node_ids : Array[String], start_has_piece : bool) -> Array[NodesDraw]:
	var draws : Array[NodesDraw] = []
	var helper_dict : Dictionary[String, bool] = {}
	var add_draws = func(from_id : String, to_ids : Array[String]) -> void:
		for to_id : String in to_ids:
			var draw_id : String = from_id + to_id
			if not helper_dict.has(draw_id):
				helper_dict[draw_id] = true
				draws.append(NodesDraw.new(from_id, to_id))
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
