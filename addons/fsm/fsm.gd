class_name Fsm extends Node

@export var stateList: Array[String] = [ "default" ]

var states := {}
var state := 0

var stateName: String:
	get: 
		return stateList[state]
	set(value):
		state = states[value]

func _ready() -> void:
	for s in range(stateList.size()):
		states[stateList[s]] = s
