@tool
extends GraphEdit

const StateNode = preload("../src/stateNode.tscn")

var default: String
var offset := Vector2(0, 32)

@onready var menu := $menu as PopupMenu

func setup(fsm: Fsm) -> void:
	var node: GraphNode
	for state in fsm.stateList:
		node = addNode(state)
		node.position_offset = offset
		offset.x += 200

func addNode(value: String = "") -> GraphNode:
	var node = StateNode.instantiate()
	add_child(node)
	node.save(value)
	return node

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				if event.pressed:
					menu.position = get_global_mouse_position()
					menu.popup()

func _on_context_index_pressed(index: int) -> void:
	match index:
		0:
			var node := addNode()
			node.position_offset = get_local_mouse_position()
			node.text.grab_focus()
