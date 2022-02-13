extends Control

@onready var context := $context as PopupMenu

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				if event.pressed:
					context.popup()
					context.position = get_viewport().get_mouse_position()
