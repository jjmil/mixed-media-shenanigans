class_name PlayerNode extends CharacterBody2D

@export var id : String

var speed : int
var is_active : bool

signal has_died

@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var area = $Area2D

func _init() -> void:
	speed = 300
	is_active = true
	
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("left" + id, "right" + id, "up" + id, "down" + id)
	velocity = velocity.normalized()
	
	if Input.is_action_pressed("slow" + id):
		velocity *= speed / 2.0
	else:
		velocity *= speed
	
	move_and_slide()

func switch() -> void:
	is_active = !is_active
	match is_active:
		true:
			sprite.play("active")
			area.set("collision_layer", 2) # 2
			area.set("collision_mask", 4) # 3
		false:
			sprite.play("inactive")
			area.set("collision_layer", 0) # 0
			area.set("collision_mask", 0) # 0

func _on_area_2d_area_entered(_area: Area2D) -> void:
	print(name)
	print(global_position)
	print(_area.global_position)
	has_died.emit()
