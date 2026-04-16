@abstract class_name EnemyNode extends Node2D

var default_speed = 50.0
var velocity : Vector2

signal death

@onready var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var sprite = $Sprite2D

func _init() -> void:
	velocity = Vector2.ZERO

func _set_velocity(direction: Vector2, speed = default_speed) -> void:
	velocity = speed * direction.normalized()
	look_at(global_position + velocity)

func _physics_process(delta: float) -> void:
	position += velocity * delta

func _on_area_2d_area_entered(_area: Area2D) -> void:
	death.emit()
	queue_free()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	death.emit()
	queue_free()

@abstract func _shoot()
