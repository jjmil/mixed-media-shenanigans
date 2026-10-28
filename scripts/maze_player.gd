extends CharacterBody2D


const SPEED = 300.0

#var moving := false

@export var sprite : AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var hor_direction := Input.get_axis("input_left", "input_right")
	if hor_direction:
		velocity.x = hor_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var ver_direction := Input.get_axis("input_up", "input_down")
	if ver_direction:
		velocity.y = ver_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func _process(delta: float) -> void:
	if velocity.x != 0 or velocity.y != 0:
		if sprite.animation != "run":
			sprite.play("run")
	else:
		if sprite.animation != "idle":
			sprite.play("idle")

func die() -> void:
	velocity.x = 0
	velocity.y = 0
	sprite.rotation_degrees = 0
	sprite.animation = "death"
	
	get_tree().create_timer(1.0).timeout.connect(func(): get_tree().reload_current_scene())
