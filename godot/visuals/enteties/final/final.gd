extends Node3D
class_name  Final

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

@onready var body: MeshInstance3D = %body
@onready var label: Label3D = %label

#############
# variables #
#############

var glow : Glow

#############
# build-ins #
#############

func _ready() -> void:
	glow = Glow.new(body)
	
func _process(delta):
	if glow:
		glow.update(delta)

#############
# listeners #
#############

func update_number(new_content_number : int) -> void:
	label.text = str(new_content_number)

#############
# publics   #
#############

func set_color(color : Color) -> void:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	body.set_surface_override_material(0, material)

#############
# functions #
#############
