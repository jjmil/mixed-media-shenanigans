extends Node

@onready var title_screen_scene = preload("res://scenes/title_screen.tscn")
@onready var level_scene = preload("res://scenes/level.tscn")
@onready var end_screen_scene = preload("res://scenes/end_screen.tscn")

func _ready() -> void:
	_init_title()

func _init_title() -> void:
	for i in range(get_child_count()):
		remove_child(get_child(i))
	var title_screen = title_screen_scene.instantiate()
	title_screen.start_level.connect(_init_level)
	add_child(title_screen)

func _init_level() -> void:
	for i in range(get_child_count()):
		remove_child(get_child(i))
	var level = level_scene.instantiate()
	level.reset.connect(_init_level)
	level.game_end.connect(_init_end)
	add_child(level)

func _init_end(score: int) -> void:
	if (get_child_count() != 0):
		for i in range(get_child_count()):
			remove_child(get_child(i))
	var end_screen = end_screen_scene.instantiate()
	end_screen.end_level.connect(_init_title)
	end_screen.score = score
	add_child(end_screen)
