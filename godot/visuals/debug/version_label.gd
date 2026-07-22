extends Label

###########
# classes #
###########

#class InnerClass:
#	enum TYPE {A, B}
#	var type : TYPE
#	var s : String
#	var b : bool
#	func _init(_s : String, _b : bool, _type : TYPE) -> void:
#		type = _type
#		s = _s
#		b = _b

###########
# signals #
###########

#signal say_hello

#########
# enums #
#########

#enum MYVALUE {A, B, C}

#############
# constants #
#############

#const XXX : String = ""

###############
# static vars #
###############

###########
# exports #
###########

#@export var yyy : String = ""

#############
# on-readys #
#############

func _ready():
	text = str(ProjectSettings.get_setting("application/config/version"))

#############
# variables #
#############

#var xxx : String = ""

#############
# build-ins #
#############

#func _ready() -> void:
#	pass


#func _process(delta: float) -> void:
#	pass

#############
# listeners #
#############

#func _on_button_press() -> void:
#	pass

###########
# publics #
###########

#func read_a_value() -> String:
#	return xxx

#############
# functions #
#############

#func _read_another_value() -> String:
#	return XXX

################
# static funcs #
################

#static func _read_another_value() -> String:
#	return "abc"
