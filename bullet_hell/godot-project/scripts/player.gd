class_name Player extends Node

const max_count = 5
var count : int

@onready var player_node_a = $PlayerNodeA

signal has_died

func _on_player_node_has_died() -> void:
	has_died.emit()
