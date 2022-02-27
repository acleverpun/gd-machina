extends Node

@onready var sm: Machina = $machina as Machina

func _ready() -> void:
	pass

	sm.changed.connect(_on_sm_changed)

	sm.change(sm.states.bard)
	sm.change(sm.FOOD)

func _on_sm_changed(state: StringName, oldState: StringName) -> void:
	prints("state changed from %s to %s" % [ oldState, state ])
