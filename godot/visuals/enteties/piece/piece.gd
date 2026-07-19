extends Node3D
class_name Piece

#############
# signals   #
#############

#############
# enums     #
#############

#############
# constants #
#############

#############
# exports   #
#############

#############
# on-readys #
#############

@onready var body : MeshInstance3D = %body

#############
# variables #
#############

#############
# build-ins #
#############

#############
# listeners #
#############

#############
# publics   #
#############

func set_color(color : Color) -> void:
	var material : StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = color
	body.set_surface_override_material(0, material)

#############
# functions #
#############
