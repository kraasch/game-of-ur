extends RefCounted
class_name  Glow

var mesh : MeshInstance3D
var material
var blinking : bool = false
var blink_time : float = 0.0

const COLOR : Color = Color.CYAN
const DEFAULT_COLOR : Color = Color.WHITE
const DEFAULT_EMISSION : float = 0.0

func _init(_mesh : MeshInstance3D) -> void:
	mesh = _mesh
	material = mesh.get_active_material(0).duplicate() as StandardMaterial3D
	mesh.set_surface_override_material(0, material)
	material.emission_enabled = true
	material.emission = COLOR
	material.emission_energy_multiplier = 0.0

func enable_glow(color : Color = Color.CYAN, strength : float = 5.0):
	var mat : StandardMaterial3D = mesh.get_surface_override_material(0)
	if mat == null:
		mat = material.duplicate()
		mesh.set_surface_override_material(0, mat)
	mat.emission_enabled = true
	mat.emission = color
	mat.emission_energy_multiplier = strength

func reset_glow():
	var mat : StandardMaterial3D = mesh.get_surface_override_material(0)
	if mat:
		mat.emission_enabled = false
		mat.emission = DEFAULT_COLOR
		mat.emission_energy_multiplier = DEFAULT_EMISSION

func set_focus():
	blinking = true

func reset_focus():
	blinking = false
	#material.emission_energy_multiplier = 0.0 # TODO: remove this line.

func update(delta : float):
	if not blinking:
		return
	blink_time += delta
	var t = (sin(blink_time * TAU * 0.5) + 1.0) * 0.5
	material.emission_energy_multiplier = lerp(0.5, 5.0, t)
