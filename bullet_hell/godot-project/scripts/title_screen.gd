extends Node

signal start_level

func _on_button_pressed() -> void:
	start_level.emit()
