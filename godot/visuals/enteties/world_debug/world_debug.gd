extends RefCounted
class_name  WorldDebug

const DEBUG_DIST: float = 200.0

const SHOW_DEBUG_LINES: bool = false

var container : Node3D

func _init(_container : Node3D) -> void:
	container = _container

func create_debug_bounding_box() -> void:
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	var imm: ImmediateMesh = ImmediateMesh.new()
	mesh_instance.mesh = imm
	var half: float = DEBUG_DIST
	var colors := [
		Color.RED,
		Color.GREEN,
		Color.YELLOW,
		Color.BLUE,
		Color.CYAN,
		Color.MAGENTA
	]
	var add_face = func(): pass 
	if not SHOW_DEBUG_LINES:
		imm.surface_begin(Mesh.PRIMITIVE_TRIANGLES)
		add_face = func(a: Vector3, b: Vector3, c: Vector3, d: Vector3, col: Color) -> void:
			imm.surface_set_color(col)
			imm.surface_add_vertex(a)
			imm.surface_add_vertex(b)
			imm.surface_add_vertex(c)
			imm.surface_add_vertex(a)
			imm.surface_add_vertex(c)
			imm.surface_add_vertex(d)
	else:
		imm.surface_begin(Mesh.PRIMITIVE_LINES)
		add_face = func(a: Vector3, b: Vector3, c: Vector3, d: Vector3, col: Color) -> void:
			imm.surface_set_color(col)
			imm.surface_add_vertex(a); imm.surface_add_vertex(b)
			imm.surface_add_vertex(b); imm.surface_add_vertex(c)
			imm.surface_add_vertex(c); imm.surface_add_vertex(d)
			imm.surface_add_vertex(d); imm.surface_add_vertex(a)
	var p := [
		Vector3(-half, -half, -half),
		Vector3( half, -half, -half),
		Vector3( half,  half, -half),
		Vector3(-half,  half, -half),
		Vector3(-half, -half,  half),
		Vector3( half, -half,  half),
		Vector3( half,  half,  half),
		Vector3(-half,  half,  half)
	]
	add_face.call(p[0], p[1], p[2], p[3], colors[0]) # back
	add_face.call(p[4], p[5], p[6], p[7], colors[1]) # front
	add_face.call(p[0], p[1], p[5], p[4], colors[2]) # bottom
	add_face.call(p[3], p[2], p[6], p[7], colors[3]) # top
	add_face.call(p[1], p[2], p[6], p[5], colors[4]) # right
	add_face.call(p[0], p[3], p[7], p[4], colors[5]) # left
	imm.surface_end()
	var mat: StandardMaterial3D = StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mat.vertex_color_use_as_albedo = true
	mesh_instance.material_override = mat
	container.add_child(mesh_instance)
