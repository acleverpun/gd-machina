@tool
class_name Machina extends Node

## State was added.
signal added(state: StringName)
## State was removed.
signal removed(state: StringName)
## State was edited.
signal edited(state: StringName, oldState: StringName)
## Active state was changed.
signal changed(state: StringName, oldState: StringName)

var default: String
var state: String

## Pseudo-enum collection of states.
var states := {}

var _keys := {}
var _nodes := {}

func _ready() -> void:
	var children := get_children()
	var key: StringName

	# populate states
	for node in children:
		key = node.name
		_keys[_to_screaming_snake(key)] = key
		_nodes[key] = node
		states[key] = key

	# set default if unset
	if default == "" and children.size() > 0:
		default = children[0].name

	# set initial state if unset
	if state == "":
		state = default

# make exported variables use actual states
func _get_property_list() -> Array:
	var nodes = get_children().map(func(child): return child.name)
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
			hint_string = ",".join(nodes),
		},
		{
			name = "state",
			type = TYPE_STRING,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE,
			hint = PROPERTY_HINT_ENUM,
			hint_string = ",".join(nodes),
		},
	]

# proxy states to instance
func _get(property: StringName):
	return _keys.get(property)

## Add a state.
func add(key: String) -> void:
	var node := Node.new()
	node.name = key
	add_child(node)
	node.owner = get_tree().get_edited_scene_root()

	_keys[_to_screaming_snake(key)] = key
	_nodes[key] = node
	states[key] = key

	added.emit(key)
	notify_property_list_changed()

## Remove a state.
func remove(key: StringName) -> void:
	var node: Node = _nodes[key]
	node.queue_free()

	_keys.erase(_to_screaming_snake(key))
	_nodes.erase(key)
	states.erase(key)

	removed.emit(key)
	notify_property_list_changed()

## Edit a state.
func edit(key: StringName, newKey: StringName) -> void:
	var node: Node = _nodes[key]
	node.name = newKey

	_keys.erase(_to_screaming_snake(key))
	_nodes.erase(key)
	states.erase(key)

	_keys[_to_screaming_snake(newKey)] = node
	_nodes[newKey] = node
	states[newKey] = newKey

	edited.emit(newKey, key)
	notify_property_list_changed()

## Change active state.
func change(key: StringName) -> void:
	assert(key in states, "state not found")

	var oldState: StringName = state
	state = key
	changed.emit(key, oldState)

## Convert string to SCREAMING_SNAKE_CASE.
func _to_screaming_snake(value: String) -> String:
	return value.to_upper().replace("-", "_").replace(" ", "_")
