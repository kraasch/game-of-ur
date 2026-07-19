extends Location
class_name Area

#############
# signals   #
#############

signal content_number_changed

#############
# enums     #
#############

### Type of area is either start or end.
enum AREA_TYPE {START, END}

#############
# constants #
#############

const NUMBER_OF_PIECES_INITIAL : int = 7
const NUMBER_OF_PIECES_NONE : int = 0

#############
# exports   #
#############

#############
# on-readys #
#############

#############
# variables #
#############

### The actual type of area.
var type : AREA_TYPE

### Number of pieces contained in each area.
var number_of_pieces : int = 0 # NOTE: usually between 0 and 7.

#############
# build-ins #
#############

func _to_string() -> String:
	var type_str : String = 'unknown'
	if type == AREA_TYPE.START:
		type_str = 'START'
	elif type == AREA_TYPE.END:
		type_str = 'END'
	return 'Area(type:' + str(type_str) + ', pices:' + str(number_of_pieces) + ')'

func _init(_type : AREA_TYPE) -> void:
	type = _type
	match type:
		AREA_TYPE.START:
			number_of_pieces = NUMBER_OF_PIECES_INITIAL
		AREA_TYPE.END:
			number_of_pieces = NUMBER_OF_PIECES_NONE

#############
# listeners #
#############

#############
# publics   #
#############

# NOTE: testing end to have all pieces is technically enough of a test.
static func is_win_condition(start : Area, end : Area) -> bool:
	var start_has_none : bool = start.number_of_pieces == NUMBER_OF_PIECES_NONE
	var end_has_all : bool = end.number_of_pieces == NUMBER_OF_PIECES_INITIAL
	return start_has_none and end_has_all

func set_number_of_pieces(_number_of_pieces : int) -> void:
	number_of_pieces = _number_of_pieces
	content_number_changed.emit(number_of_pieces)

func increase_number_of_pieces() -> void:
	number_of_pieces += 1
	content_number_changed.emit(number_of_pieces)

func decrease_number_of_pieces() -> void:
	number_of_pieces -= 1
	content_number_changed.emit(number_of_pieces)

#############
# functions #
#############
