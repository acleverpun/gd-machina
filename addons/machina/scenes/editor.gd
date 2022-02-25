@tool
extends GraphEdit

const StateNode = preload("../src/stateNode.tscn")

var default: String
var sm: Machina
var offset := Vector2(0, 32)

@onready var menu := $menu as PopupMenu

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				if event.pressed:
					menu.position = get_global_mouse_position()
					menu.popup()

func setup(machina: Machina) -> void:
	sm = machina
	for state in sm.states:
		var stateNode := addNode(state)
		stateNode.position_offset = offset
		offset.x += 200

func addNode(value: String = "") -> GraphNode:
	var stateNode = StateNode.instantiate()
	add_child(stateNode)
	stateNode.save(value)
	stateNode.saved.connect(_on_stateNode_saved.bind(stateNode))
	return stateNode

func _on_context_index_pressed(index: int) -> void:
	match index:
		0: # add node
			var stateNode := addNode()
			stateNode.position_offset = get_local_mouse_position()
			stateNode.text.grab_focus()

func _on_stateNode_saved(stateNode: GraphNode) -> void:
	prints("saved", stateNode)
