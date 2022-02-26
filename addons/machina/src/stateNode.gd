@tool
extends GraphNode

signal saved(value: String)

var text: LineEdit

func reset(value: String) -> void:
	text = $container/text as LineEdit
	title = value
	text.text = ""
	text.release_focus()

func save(value: String) -> void:
	emit_signal("saved", value)

func _on_text_text_submitted(value: String) -> void:
	save(value)
