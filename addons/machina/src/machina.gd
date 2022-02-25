@tool
class_name Machina extends Node

var default: String
var state: String

var states := {}

func _ready() -> void:
	var children := get_children()

	# populate states
	for node in children:
		states[node.name] = node

	# set default if unset
	if default == "" and children.size() > 0:
		default = children[0].name

	# set initial state if unset
	if state == "":
		state = default

# make exported variables use actual states
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

# proxy states to instance
func _get(property: StringName):
	if states.has(property):
		return states[property]
	return null
