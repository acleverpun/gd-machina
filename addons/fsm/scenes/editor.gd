@tool
extends GraphEdit

const StateNode = preload("../src/stateNode.tscn")

var default: String

@onready var menu := $menu as PopupMenu

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
			var node = StateNode.instantiate()
			node.position_offset = get_local_mouse_position()
			add_child(node)
