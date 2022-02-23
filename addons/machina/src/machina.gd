@tool
class_name Machina extends Node

var default: String
var state: String

func _ready() -> void:
	state = default

func _get_property_list() -> Array:
	var states = get_children().map(func(child): return child.name)
	return [
		{
			name = "main",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY,
		},
		{
			name = "default",
			type = TYPE_STRING,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE,
			hint = PROPERTY_HINT_ENUM,
			hint_string = ",".join(states),
		},
		{
			name = "state",
			type = TYPE_STRING,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE,
			hint = PROPERTY_HINT_ENUM,
			hint_string = ",".join(states),
		},
	]
