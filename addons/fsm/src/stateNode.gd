class_name StateNode extends GraphNode

@onready var container = $container as HBoxContainer
@onready var text = container.get_node("text") as LineEdit
@onready var edit = container.get_node("edit") as Button

func _ready() -> void:
	pass

func _on_edit_toggled(editMode: bool) -> void:
	text.visible = editMode
	text.editable = editMode

	if not editMode:
		title = text.text
