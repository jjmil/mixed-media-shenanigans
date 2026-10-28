extends CharacterBody2D


@export var speed = 300.0
@export var x_direction = 0
@export var y_direction = 0

@onready var down = $RayCastDown
@onready var up = $RayCastUp
@onready var left = $RayCastLeft
@onready var right = $RayCastRight

func _physics_process(delta: float) -> void:

	
	if x_direction:
		velocity.x = x_direction * speed
	if y_direction:
		velocity.y = y_direction * speed
	
	if down.is_colliding() and y_direction != 0:
		y_direction = -1
	if up.is_colliding() and y_direction != 0:
		y_direction = 1
	if left.is_colliding() and x_direction != 0:
		x_direction = 1
	if right.is_colliding() and x_direction != 0:
		x_direction = -1

	move_and_slide()



func _on_enem_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()
