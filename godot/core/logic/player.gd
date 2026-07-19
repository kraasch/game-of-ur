extends RefCounted
class_name Player

#############
# signals   #
#############

#############
# enums     #
#############

#############
# constants #
#############

static var P1 : Player = Player.new(0, Color.BLUE)
static var P2 : Player = Player.new(1, Color.RED)
static var P3 : Player = Player.new(2, Color.GREEN)
static var P4 : Player = Player.new(3, Color.ORANGE)
static var PLAYERS : Array[Player] = [P1, P2, P3, P4]

#############
# exports   #
#############

#############
# on-readys #
#############

#############
# variables #
#############

var id : int = -1
var color : Color
var start : Area
var end : Area

#############
# build-ins #
#############

func _init(_id : int, _color : Color) -> void:
	id = _id
	color = _color
	start = Area.new(Area.AREA_TYPE.START)
	end = Area.new(Area.AREA_TYPE.END)

#############
# listeners #
#############

#############
# publics   #
#############

static func int_to_player(i : int) -> Player:
	if i < 0 or i >= 4:
		return null
	return PLAYERS[i]

static func player_to_int(player : Player) -> int:
	match player:
		P1:
			return 0
		P2:
			return 1
		P3:
			return 2
		P4:
			return 3
	return -1

func get_area(area_type : Area.AREA_TYPE) -> Area:
	match area_type:
		Area.AREA_TYPE.START:
			return start
		Area.AREA_TYPE.END:
			return end
	return null

#############
# functions #
#############
