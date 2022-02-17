class_name StateNode extends GraphNode

@onready var container = $container as HBoxContainer
@onready var text = container.get_node("text") as LineEdit
@onready var editBtn = container.get_node("edit") as Button

func _ready() -> void:
	pass

func save() -> void:
	title = text.text

func edit(active: bool) -> void:
	text.visible = active
	text.editable = active

	if active:
		text.grab_focus()
	else:
		editBtn.set_pressed_no_signal(false)
		save()

func _on_edit_toggled(active: bool) -> void:
	edit(active)

func _on_text_text_submitted(value: String) -> void:
	edit(false)
