extends Node3D
class_name Field

#############
# signals   #
#############

#############
# enums     #
#############

enum STYLE {SIMPLE, TRIANGLE, HEART}

#############
# constants #
#############

#############
# exports   #
#############

#############
# on-readys #
#############

@onready var shader_surface: MeshInstance3D = %inner
@onready var heart_shader: Shader = preload("res://shaders/heart.gdshader")
@onready var card_shader: Shader = preload("res://shaders/card.gdshader")
@onready var outer: MeshInstance3D = $outer
@onready var piece: Piece = %piece

#############
# variables #
#############

var glow : Glow

#############
# build-ins #
#############

func _ready() -> void:
	glow = Glow.new(outer)
	
func _process(delta):
	if glow:
		glow.update(delta)

#############
# listeners #
#############

#############
# publics   #
#############

func show_piece_of_player(player : Player) -> void:
	piece.set_color(player.color)
	piece.visible = true

func hide_piece() -> void:
	piece.visible = false

func set_surface(style : STYLE) -> void:
	match style:
		STYLE.SIMPLE:
			return
		STYLE.TRIANGLE:
			_set_mesh_shader(shader_surface, card_shader)
		STYLE.HEART:
			_set_mesh_shader(shader_surface, heart_shader)

#############
# functions #
#############

func _set_mesh_shader(mesh_instance: MeshInstance3D, shader: Shader) -> void:
	var material : Material = mesh_instance.get_active_material(0)
	if material == null:
		material = ShaderMaterial.new()
	else:
		material = material.duplicate()
	if material is ShaderMaterial:
		material.shader = shader
	mesh_instance.set_surface_override_material(0, material)
