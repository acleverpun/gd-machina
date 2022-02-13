@tool
extends EditorPlugin

const FsmEditor := preload("./scenes/editor.tscn")

var editor: Control

func _enter_tree() -> void:
	editor = FsmEditor.instantiate()
	add_control_to_bottom_panel(editor, "FSM")

func _exit_tree() -> void:
	remove_control_from_bottom_panel(editor)
	editor.queue_free()
