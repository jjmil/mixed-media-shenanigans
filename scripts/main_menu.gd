extends Control

@export var plat_button: Button
@export var shmup_button: Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_plat_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main scenes/platformer_main.tscn")

func _on_shmup_button_pressed() -> void:
	pass
