extends Node

@onready var sm := $machina as Machina

func _ready() -> void:
	prints(sm.get_children())
