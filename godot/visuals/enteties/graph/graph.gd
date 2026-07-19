extends RefCounted
class_name  Graph

var container : Node3D

func _init(_container : Node3D) -> void:
	container = _container

func draw_graph(edges: Array, color: Color) -> void:
	# edges: Array of [Vector3, Vector3]
	var mesh := ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	for edge in edges:
		var from: Vector3 = edge[0]
		var to: Vector3 = edge[1]
		_draw_arrow(mesh, from, to, color)
	mesh.surface_end()
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	var material := ORMMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	mi.material_override = material
	container.add_child(mi)

func _draw_arrow(mesh: ImmediateMesh, from: Vector3, to: Vector3, color: Color) -> void:
	mesh.surface_set_color(color)
	mesh.surface_add_vertex(from)
	mesh.surface_add_vertex(to)
	var dir := (to - from).normalized()
	# Pick an axis that's not parallel to the edge.
	var up := Vector3.UP
	if abs(dir.dot(up)) > 0.95:
		up = Vector3.RIGHT
	var side := dir.cross(up).normalized()
	var head_length := 0.25
	var head_width := 0.12
	var base := to - dir * head_length
	mesh.surface_add_vertex(to)
	mesh.surface_add_vertex(base + side * head_width)
	mesh.surface_add_vertex(to)
	mesh.surface_add_vertex(base - side * head_width)
