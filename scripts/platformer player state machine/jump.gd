extends base_state

#@onready var jump_time = $Jump_Time

# var player = central
var ceased = false


# Called when entering this state
func enter_state(player_node):
	super(player_node) # Correct way to call the parent class method
	
	if Input.is_action_just_pressed("input_up") && central.jump_available:
		central.velocity.y = central.jump_velocity
		ceased = false
		central.jump_available = false
	else:
		if central.jump_available:
			get_tree().create_timer(central.coyote_time).timeout.connect(central.coyote_timeout)

func handle_input(_delta):
	if Input.is_action_just_pressed("input_up"):
		if central.jump_available:
			jump()
		else:
			central.jump_buffer = true
			get_tree().create_timer(central.jump_buffer_time).timeout.connect(on_jump_buffer_timeout)
	else:
		if central.jump_available:
			if central.coyote_timer.is_stopped():
				central.coyote_timer.start(central.coyote_time)
			#get_tree().create_timer(central.coyote_time).timeout.connect(central.coyote_timeout)
	var direction = Input.get_axis("input_left", "input_right")
	if direction != 0:
		# central.velocity.x = direction * central.speed
		central.accelerate(direction)
	else:
		# central.velocity.x = 0
		central.add_friction()
		
	# Allows for variable jump height based on the amount of time the player holds the jump button
	# Upward momentum stops when input ceases
	if (!Input.is_action_pressed("input_up")):
		if !ceased:
			cease()
			ceased = true
	
	# Plays the jumping animation if the player is moving up and the falling anim otherwise
	if sign(central.velocity.y) == 1:
		central.player_sprite.rotation_degrees = 0
		central.player_sprite.animation = "fall"
	else:
		central.player_sprite.rotation_degrees = 0
		central.player_sprite.animation = "jump"
	
	if central.is_on_floor():
		central.jump_available = true
		central.coyote_timer.stop()
		if central.jump_buffer:
			jump()
			central.jump_buffer = false
		elif direction == 0:
			central.change_state("Idle")
		else:
			central.change_state("Run")
		

func cease():
	# use these values to determine the lowest short hop possible
	if central.velocity.y < -1500:
		central.velocity.y = -1500

func jump()->void:
	central.velocity.y = central.jump_velocity
	ceased = false
	central.jump_available = false

func on_jump_buffer_timeout()->void:
	central.jump_buffer = false
