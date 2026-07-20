extends Node
class_name Global

#############
# signals   #
#############

#############
# enums     #
#############

#############
# constants #
#############

const NL : String = '\n'

#############
# exports   #
#############

#############
# on-readys #
#############

#############
# varaibles #
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

static func shuffle_with_rng(array : Array, rng : RandomNumberGenerator) -> void:
	for i in range(array.size() - 1, 0, -1):
		var j : int = rng.randi_range(0, i)
		var temp = array[i]
		array[i] = array[j]
		array[j] = temp

static func get_mesh_center(mesh_instance : MeshInstance3D) -> Vector3:
	if mesh_instance.mesh == null:
		return mesh_instance.global_position
	var aabb : AABB = mesh_instance.mesh.get_aabb()
	return mesh_instance.global_transform * aabb.get_center()

#############
# functions #
#############
