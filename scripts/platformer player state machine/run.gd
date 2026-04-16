extends base_state

# var player = central

func enter_state(player_node):
	super(player_node) # Correct way to call the parent class method
	# central.velocity.x = 0
	central.player_sprite.rotation_degrees = 0
	central.player_sprite.animation = "run"

func handle_input(_delta):
	var direction = Input.get_axis("input_left", "input_right")
	if direction != 0:
		central.accelerate(direction)
		# central.velocity.x = direction * central.speed
		central.player_sprite.animation = "run"
	else:
		central.change_state("Idle")
	# Trigger jump while moving
	if Input.is_action_just_pressed("input_up"):
		central.change_state("Jump")
	if !central.is_on_floor():
		central.change_state("Jump")
