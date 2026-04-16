extends Node2D

class_name Enemy

@export var dmg_particle: PackedScene
@export var score_popup: PackedScene
@export var flash_timer: Timer

@export var direction = 1
@export var set_speed = 40
@export var hp = 1
@export var score = 5
@export var init_state = "Idle"

# determines whether or not the node immediately unhides itself (debug only)
@export var init_active = true

var speed = 0

var factor = 1

# current_state is needed for state machine to function
var current_state

@onready var ray_right = $RayCastRight
@onready var ray_left = $RayCastLeft
@onready var sprite = $AnimatedSprite2D

@onready var collider = $CollisionShape2D
func change_state(new_state_name: String):
	# This is a function required in a node's script for the state machine
	#  within it to work properly
	#   change_state should be used in _ready to set the initial state
	if current_state:
		current_state.exit_state() # Exit current state
	current_state = get_node(new_state_name)
	if current_state: # Ensure new state exists
		current_state.enter_state(self) # Enter new state with central node (self)

func _ready():
	# change_state("Jeremy")
	visible = false
	collider.disabled = false
	if (init_active):
		unhide()

func unhide():
	visible = true
	# collider.disabled = false
	change_state("Jeremy")

func _physics_process(delta):
	if visible:
		position.x += direction * speed * delta

func _process(delta):
	if visible:
		if ray_right.is_colliding():
			if (!ray_right.get_collider().is_in_group("player") 
			and !ray_right.get_collider().is_in_group("changer")):
				direction = -1
		if ray_left.is_colliding():
			if (!ray_left.get_collider().is_in_group("player") 
			and !ray_left.get_collider().is_in_group("changer")):
				direction = 1
		
		if direction == 1:
			sprite.flip_h = false
		if direction == -1:
			sprite.flip_h = true
		
		if (hp == 0 and current_state != get_node("Death")):
			change_state("Death")

func _on_hitbox_entered(body):
	if visible:
		if (body.is_in_group("player") and current_state != get_node("Death")):
			body.attempt_hit()

func _on_animation_finished():
	if current_state == get_node("Death"):
		queue_free()
	if current_state == get_node("Jeremy"):
		change_state(init_state)

func score_change():
	pass
	#levels.score_counter.increase_score(score*factor)
	#if score_popup:
		#var text = score_popup.instantiate()
		#text.amount = (score*factor)
		#text.global_position = global_position
		#if rotation != -0:
			#text.global_position.y += 32
		#else:
			#text.global_position.y -= sign(scale.y) * 32
		#get_tree().root.add_child(text)

func make_particle(particle: PackedScene):
	# code to instantiate and emit a preloaded particle
	if particle:
			var inst = particle.instantiate()
			add_child(inst)
			inst.scale.y = scale.y
			inst.position.y -= 32
			inst.emitting = true
			
func flash():
	if flash_timer:
		sprite.set_instance_shader_parameter("flash_modifier", 0.75)
		#print("STARTING TIMER")
		flash_timer.start()

func attempt_hit():
	# ensures enemy is in a valid state and then creates its damage particle and loses one hp
	if current_state != get_node("Death") and current_state != get_node("Jeremy"):
		flash()
		hp -= 1
