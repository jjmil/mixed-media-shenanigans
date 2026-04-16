extends Node

var score : int

@onready var label = $Label

signal end_level

func _ready() -> void:
	update_score()

func update_score():
	label.text = "Final Score: " + str(score)

func _on_button_pressed() -> void:
	end_level.emit()
