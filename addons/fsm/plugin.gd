@tool
extends EditorPlugin

const NodeName := "FiniteStateMachine"

const FsmEditor := preload("./scenes/editor.tscn")

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

func toggle(visible: bool, fsm: FiniteStateMachine) -> void:
	if visible:
		editor = FsmEditor.instantiate()
		editor.setup(fsm)
		add_control_to_bottom_panel(editor, "FSM")
	else:
		if editor != null:
			remove_control_from_bottom_panel(editor)
			editor.queue_free()
			editor = null

func _on_selection_changed() -> void:
	var nodes = selection.get_selected_nodes()
	var isFsm := not nodes.is_empty() and nodes[0] is FiniteStateMachine
	var fsm: FiniteStateMachine = nodes[0] if isFsm else null

	toggle(isFsm, fsm)
