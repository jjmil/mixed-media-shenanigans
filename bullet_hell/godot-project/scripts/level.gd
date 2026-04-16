extends Node

var max_enemies : int
var score : int

@onready var score_label = $ScoreLabel
@onready var count_label = $CountLabel
@onready var player = $Player
@onready var spawner = $EnemySpawner

signal reset
signal game_end(score)

func _init() -> void:
	score = 0
	max_enemies = 2

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	
	while (spawner.enemies < max_enemies):
		spawner.spawn()
	
	if Input.is_action_pressed("reset"):
		reset.emit()
	
	score += 1
	score_label.text = "Score: " + str(score)
	count_label.text = str(player.count)

func _on_player_has_died() -> void:
	game_end.emit(score)

func _on_timer_timeout() -> void:
	max_enemies += 1

func _exit_tree() -> void:
	for i in range(get_child_count()):
		get_child(i).queue_free()
