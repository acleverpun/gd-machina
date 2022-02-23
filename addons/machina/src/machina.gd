@tool
class_name Machina extends Node

@export var keys: Array[String] = []

var states := {}
var state := 0

var stateName: String:
	get:
		return keys[state]
	set(value):
		state = states[value]

func _ready() -> void:
	for k in range(keys.size()):
		states[keys[k]] = k

func add(value: String) -> void:
	keys.append(value)

func remove(value: String) -> void:
	var index := keys.find(value)
	if index >= 0:
		keys.remove_at(index)

func update(value: String) -> void:
	var index := keys.find(value)
	if index >= 0:
		keys.remove_at(index)
