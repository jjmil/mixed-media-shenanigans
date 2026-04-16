class_name ArcEnemy extends EnemyNode

var arc_vector : Vector2
var arc_rot_angle : float

@onready var cooldown_timer = $CooldownTimer

func _init() -> void:
	var speed = 50.0
	
	var init_rot = randf_range(-PI/3, PI/3)
	var direction = Vector2.DOWN
	direction = direction.rotated(init_rot)
	direction = direction.normalized()
	_set_velocity(direction, speed)
	
	arc_vector = transform.x
	arc_rot_angle = PI / 8

func _shoot():
	cooldown_timer.start()
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance._set_velocity(arc_vector)
	bullet_instance.global_position = global_position
	get_parent().add_child(bullet_instance)
	
	arc_vector = arc_vector.rotated(arc_rot_angle)
