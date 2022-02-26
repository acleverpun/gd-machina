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
		return property
	return null

## Add a state.
func add(key: StringName) -> void:
	var node := Node.new()
	node.name = key
	add_child(node)
	node.owner = get_tree().get_edited_scene_root()
	states[key] = node
	added.emit(key)
	notify_property_list_changed()

## Remove a state.
func remove(key: StringName) -> void:
	var node: Node = states[key]
	node.queue_free()
	states.erase(key)
	removed.emit(key)
	notify_property_list_changed()

## Edit a state.
func edit(key: StringName, newKey: StringName) -> void:
	var node: Node = states[key]
	node.name = newKey
	states.erase(key)
	states[newKey] = node
	edited.emit(newKey, key)
	notify_property_list_changed()

## Change active state.
func change(key: StringName) -> void:
	assert(key in states, "state not found")
	var oldState := state
	state = key
	changed.emit(key, oldState)
