@tool
extends GraphEdit

@export_node_path(Node) var smPath

const StateNode = preload("../src/stateNode.tscn")

var offset := Vector2(0, 32)

@onready var menu := $menu as PopupMenu
@onready var sm := get_node(smPath) as Machina

func _ready() -> void:
	sm.ready.connect(setup)
	setup()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				if event.pressed:
					menu.position = get_global_mouse_position()
					menu.popup()

func setup() -> void:
	for state in sm.states:
		var stateNode := addNode(state)
		stateNode.position_offset = offset
		offset.x += 200

func addNode(value: String = "") -> GraphNode:
	var stateNode: GraphNode = StateNode.instantiate()
	add_child(stateNode)
	stateNode.reset(value)
	stateNode.saved.connect(_on_stateNode_saved.bind(stateNode))
	stateNode.close_request.connect(_on_stateNode_close_request.bind(stateNode))
	return stateNode

func _on_context_index_pressed(index: int) -> void:
	match index:
		0: # add node
			var stateNode := addNode()
			stateNode.position_offset = get_local_mouse_position()
			stateNode.text.grab_focus()

func _on_stateNode_saved(value: String, stateNode: GraphNode) -> void:
	var state := stateNode.title

	if state == "":
		sm.add(value)
	else:
		sm.rename(state, value)

	stateNode.reset(value)

func _on_stateNode_close_request(stateNode: GraphNode) -> void:
	sm.remove(stateNode.title)
	stateNode.queue_free()
