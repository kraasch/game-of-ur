extends RefCounted
class_name  Graph

var container : Node3D
var tweens : Array[Tween] = []

func _init(_container : Node3D) -> void:
	container = _container

func update_show_paths(_show_paths : bool) -> void:
	if not _show_paths:
		if len(tweens) > 0:
			_remove_tweens()

func _remove_tweens() -> void:
	for tween in tweens:
		tween.kill()
	tweens = []
		

func draw_graph(edges : Array, color : Color, board_offset : Vector3, pid : int, max_players : int) -> void:
	const Y_OFFSET : Vector3 = Vector3(0, 0.6, 0)
	const CELL_OFFSET : Vector3 = Vector3(0.5, 0.0, 0.5)
	#const PLAYER_DIFF : Vector3 = Vector3(0.15, 0.01, 0.15) # TODO: use this line on debug.
	const PLAYER_DIFF : Vector3 = Vector3(0.05, 0.01, 0.05)
	var player_offset : Vector3 = Vector3.ZERO
	match pid:
		0:
			player_offset -= PLAYER_DIFF
		1:
			player_offset += PLAYER_DIFF
		2:
			player_offset -= PLAYER_DIFF * 2
		3:
			player_offset += PLAYER_DIFF * 2
	var offset : Vector3 = board_offset + CELL_OFFSET + Y_OFFSET + player_offset
	# edges: Array of [Vector3, Vector3]
	var mesh : ImmediateMesh = ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES)
	for edge in edges:
		var from: Vector3 = edge[0] + offset
		var to: Vector3 = edge[1] + offset
		_draw_arrow(mesh, from, to, color)
	mesh.surface_end()
	var mi : MeshInstance3D = MeshInstance3D.new()
	mi.mesh = mesh
	var material : ORMMaterial3D = ORMMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	mi.material_override = material
	container.add_child(mi)
	_animate_graph(mi, pid, max_players)

# NOTE: use this one for debugging or attach to debug mode.
# TODO: attach these to the debug flag.
func _draw_simple_arrow(mesh : ImmediateMesh, from : Vector3, to : Vector3, color : Color) -> void:
	mesh.surface_set_color(color)
	mesh.surface_add_vertex(from)
	mesh.surface_add_vertex(to)
	var dir : Vector3 = (to - from).normalized()
	# Pick an axis that's not parallel to the edge.
	var up : Vector3 = Vector3.UP
	if abs(dir.dot(up)) > 0.95:
		up = Vector3.RIGHT
	var side : Vector3 = dir.cross(up).normalized()
	var head_length : float = 0.25
	var head_width : float = 0.12
	var base : Vector3 = to - dir * head_length
	mesh.surface_add_vertex(to)
	mesh.surface_add_vertex(base + side * head_width)
	mesh.surface_add_vertex(to)
	mesh.surface_add_vertex(base - side * head_width)

func _draw_arrow(mesh: ImmediateMesh, from: Vector3, to: Vector3, color: Color) -> void:
	mesh.surface_set_color(color)
	var width : float = 0.12
	var head_length : float = 0.30
	var head_width : float = 0.28
	var dir : Vector3 = (to - from).normalized()
	var side : Vector3 = Vector3(-dir.z, 0.0, dir.x).normalized()
	var shaft_end : Vector3 = to - dir * head_length
	var l0 : Vector3 = from + side * width * 0.5
	var r0 : Vector3 = from - side * width * 0.5
	var l1 : Vector3 = shaft_end + side * width * 0.5
	var r1 : Vector3 = shaft_end - side * width * 0.5
	# shaft.
	mesh.surface_add_vertex(l0)
	mesh.surface_add_vertex(r0)
	mesh.surface_add_vertex(l1)
	mesh.surface_add_vertex(r0)
	mesh.surface_add_vertex(r1)
	mesh.surface_add_vertex(l1)
	# arrow head.
	var hl : Vector3 = shaft_end + side * head_width * 0.5
	var hr : Vector3 = shaft_end - side * head_width * 0.5
	mesh.surface_add_vertex(hl)
	mesh.surface_add_vertex(hr)
	mesh.surface_add_vertex(to)

func _animate_graph(mi: MeshInstance3D, pid: int, max_players : int) -> void:
	const SLOT_DURATION : float = 2.0
	const FADE_TIME : float = 0.15
	const VISIBILITY_FACTOR : float = 2.0
	var mat : BaseMaterial3D = mi.material_override as BaseMaterial3D
	if mat == null:
		push_error("error: raph material missing.")
		return
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	# make a unique material instance not to fade all arrows together.
	mat = mat.duplicate()
	mi.material_override = mat
	var color : Color = mat.albedo_color
	color.a = 0.0
	mat.albedo_color = color
	var tween : Tween = container.create_tween()
	tweens.append(tween)
	tween.set_loops()
	# offset each player's animation start.
	tween.tween_interval(pid * SLOT_DURATION)
	# fade in.
	tween.tween_method(
		func(alpha : float):
			var c : Color = mat.albedo_color
			c.a = alpha
			mat.albedo_color = c,
		0.0,
		1.0,
		FADE_TIME
	)
	# let the arrrow be visible
	tween.tween_interval(SLOT_DURATION - FADE_TIME * VISIBILITY_FACTOR)
	# fade out.
	tween.tween_method(
		func(alpha : float):
			var c : Color = mat.albedo_color
			c.a = alpha
			mat.albedo_color = c,
		1.0,
		0.0,
		FADE_TIME
	)
	# wait for remaining players.
	tween.tween_interval((max_players - pid - 1) * SLOT_DURATION)
