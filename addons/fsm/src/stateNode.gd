@tool
extends GraphNode

var text: LineEdit

func save(value: String) -> void:
	text = $container/text as LineEdit
	title = value
	text.text = ""
	text.release_focus()

func _on_text_text_submitted(value: String) -> void:
	save(value)
