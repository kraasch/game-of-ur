extends RefCounted
class_name Draw

#############
# signals   #
#############

#############
# enums     #
#############

enum DRAW_TYPE {NONE, CAPTURE, MOVE_TO_EMPTY, MOVE_TO_END, OCCUPIED}

#############
# constants #
#############

#############
# exports   #
#############

#############
# on-readys #
#############

#############
# variables #
#############

var from : Location
var to : Location

#############
# build-ins #
#############

func _init(_from : Location, _to : Location) -> void:
	from = _from
	to = _to

func _to_string() -> String:
	return 'Draw(from:' + str(from) + ', to:' + str(to) + ')'

#############
# listeners #
#############

#############
# publics   #
#############

#############
# functions #
#############
