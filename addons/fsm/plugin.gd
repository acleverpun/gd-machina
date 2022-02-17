@tool
extends EditorPlugin

const FsmEditor := preload("./scenes/editor.tscn")

var editor: Control
var selection: EditorSelection

func _enter_tree() -> void:
	selection = get_editor_interface().get_selection()
	selection.connect("selection_changed", _on_selection_changed)

	editor = FsmEditor.instantiate()

func _exit_tree() -> void:
	remove_control_from_bottom_panel(editor)
	editor.queue_free()

func toggle(visible: bool = true) -> void:
	if visible:
		add_control_to_bottom_panel(editor, "FSM")
	else:
		remove_control_from_bottom_panel(editor)

func _on_selection_changed() -> void:
	for node in selection.get_selected_nodes():
		if node is Fsm:
			toggle(true)
			return
	toggle(false)
