extends CharacterBody2D


#const SPEED = 1300.0
#const JUMP_VELOCITY = -2000.0
#const GRAVITY = 4000.0
const TERM_VELOCITY = 4000.0
const FASTFALL_VELOCITY = 4500.0

@export_category("Movement Parameters")
@export var jump_peak_time := 1.0
@export var jump_fall_time := 1.0
@export var jump_height := 2000.0
@export var jump_distance := 4500.0
@export var coyote_time := 0.08
@export var jump_buffer_time := 0.1

var speed := 1300.0

@export_category("Acceleration Values")
@export var acceleration := 200.0
@export var friction := 220.0
var jump_velocity := -2000.0
var jump_available := true
var jump_buffer := false

var jump_gravity := 4000.0
var fall_gravity := 4000.0

var current_state
var last_direction = 1
var x_momentum = 0
var knockback_dir := Vector2()
var knockback_wait = 0
var knockback_strength := 10.0
var knockback = false

var hp = 3

@onready var player_sprite = $AnimatedSprite2D
@onready var coyote_timer = $Coyote_Timer

@export_category("Camera")
@export var camera: Camera2D

func calculate_movement_params() -> void:
	jump_gravity = (2*jump_height)/pow(jump_peak_time,2)
	fall_gravity = (2*jump_height)/pow(jump_fall_time,2)
	jump_velocity = -(jump_gravity * jump_peak_time)
	speed = jump_distance/(jump_peak_time+jump_fall_time)

func _ready():
	change_state("Idle") # Starts the player in Idle state
	calculate_movement_params()

func change_state(new_state_name: String):
	if current_state:
		current_state.exit_state() # Exit current state
	current_state = get_node(new_state_name)
	if current_state: # Ensure new state exists
		current_state.enter_state(self) # Enter new state with player node (self)

func _physics_process(delta: float) -> void:
	# Update last facing direction based on input
	var direction = Input.get_axis("input_left", "input_right")
	# Update direction when moving left or right
	if direction != 0:
		last_direction = sign(direction)
	
	if not is_on_floor():
		# Gravity and fastfalling input
		if velocity.y <= TERM_VELOCITY:
			# stops vertical velocity from going above terminal
			if velocity.y > 0:
				velocity.y += jump_gravity * delta
			else:
				velocity.y += fall_gravity * delta
		if Input.is_action_pressed("input_down"):
			if velocity.y <= FASTFALL_VELOCITY:
				velocity.y += fall_gravity * 1.5 * delta
		elif Input.is_action_just_released("input_down") and velocity.y >= TERM_VELOCITY:
			# If fastfall input is released above terminal velocity, resets vert speed to term velocity
			velocity.y = TERM_VELOCITY
		
	# Ensure a state is active
	if current_state:
		current_state.handle_input(delta)
	move_and_slide()
	# Flip player sprite
	if direction >= 1:
		player_sprite.flip_h = false
	if direction <= -1:
		player_sprite.flip_h = true 
	
	if (hp <= 0):
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()
	

func _on_player_hurtbox_area_entered(area):
	if area.is_in_group("hitbox_enemy_atk"):
		if current_state != get_node("Dash"):
			area.queue_free()
			hp -= 1

func coyote_timeout():
	if not is_on_floor():
		jump_available = false


# Player acceleration/deceleration
func accelerate(direction):
	velocity.x = move_toward(velocity.x, speed * direction, acceleration)

func add_friction():
	velocity.x = move_toward(velocity.x, 0, friction)

func attempt_hit():
	if current_state != get_node("Death"):
		change_state("Death")
