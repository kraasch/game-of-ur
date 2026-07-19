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

static func shuffle_with_rng(array: Array, rng: RandomNumberGenerator) -> void:
	for i in range(array.size() - 1, 0, -1):
		var j := rng.randi_range(0, i)
		var temp = array[i]
		array[i] = array[j]
		array[j] = temp

#############
# functions #
#############
