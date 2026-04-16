class_name LineEnemy extends EnemyNode

enum shoot_dirs {
	LEFT, RIGHT
}
var shoot_dir : shoot_dirs

@onready var cooldown_timer = $CooldownTimer

func _init() -> void:
	var speed = 50.0
	var init_rot = randf_range(-PI/3, PI/3)
	var direction = Vector2.DOWN
	direction = direction.rotated(init_rot)
	direction = direction.normalized()
	_set_velocity(direction, speed)
	
	shoot_dir = randi_range(shoot_dirs.LEFT, shoot_dirs.RIGHT) as shoot_dirs

func _shoot():
	cooldown_timer.start()
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = global_position
	var bullet_dir = transform.y
	if (shoot_dir == shoot_dirs.RIGHT):
			bullet_dir = -bullet_dir
	bullet_instance._set_velocity(bullet_dir)
	get_parent().add_child(bullet_instance)
