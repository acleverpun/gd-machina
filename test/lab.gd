extends Node

@onready var sm: Machina = $machina as Machina

func _ready() -> void:
	pass

	sm.changed.connect(_on_sm_changed)

	sm.change(sm.bard)

func _on_sm_changed(state: StringName, oldState: StringName) -> void:
	prints("sm changed", state, oldState)
