@tool
extends GraphNode

var key: String
var text: LineEdit

func save(value: String) -> void:
	text = $container/text as LineEdit
	key = value
	title = value
	text.text = ""
	text.release_focus()

func _on_text_text_submitted(value: String) -> void:
	save(value)
