@tool
extends EditorPlugin

const NodeName := "Machina"

const MachinaEditor := preload("./scenes/editor.tscn")

var editor: GraphEdit
var selection: EditorSelection

func _enter_tree() -> void:
	if not Engine.is_editor_hint(): return

	selection = get_editor_interface().get_selection()
	selection.connect("selection_changed", _on_selection_changed)

func _exit_tree() -> void:
	if editor != null:
		remove_control_from_bottom_panel(editor)
		editor.queue_free()

func toggle(visible: bool, sm: Machina) -> void:
	if visible:
		editor = MachinaEditor.instantiate()
		editor.setup(sm)
		add_control_to_bottom_panel(editor, "Machina")
	else:
		if editor != null:
			remove_control_from_bottom_panel(editor)
			editor.queue_free()
			editor = null

func _on_selection_changed() -> void:
	var nodes = selection.get_selected_nodes()
	var isMachina := not nodes.is_empty() and nodes[0] is Machina
	var sm: Machina = nodes[0] if isMachina else null

	toggle(isMachina, sm)
