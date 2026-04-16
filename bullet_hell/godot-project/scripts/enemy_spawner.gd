class_name EnemySpawner extends Node

var enemies : float
enum enemy_types {
	LINE, ARC
}

@onready var line_enemy_scene = preload("res://scenes/line_enemy.tscn")
@onready var arc_enemy_scene = preload("res://scenes/arc_enemy.tscn")

func init():
	enemies = 0

func spawn():
	enemies += 1
	var next_enemy : EnemyNode
	var next_type := randi_range(enemy_types.LINE, enemy_types.ARC) as enemy_types 
	match next_type:
		enemy_types.LINE:
			next_enemy = line_enemy_scene.instantiate()
		enemy_types.ARC:
			next_enemy = arc_enemy_scene.instantiate()
	var next_enemy_pos = Vector2(randi_range(8, 248), 8)
	next_enemy.position = next_enemy_pos
	next_enemy.death.connect(on_death)
	add_child(next_enemy)

func on_death():
	enemies -= 1
