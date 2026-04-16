extends base_state


# var player = central

# Called when entering this state
func enter_state(player_node):
	super(player_node) # Correct way to call the parent class method
	# central.velocity.x = 0
	central.player_sprite.rotation_degrees = 0
	central.player_sprite.animation = "idle"

func handle_input(_delta):
	central.add_friction()
	if Input.is_action_just_pressed("input_up"):
		central.change_state("Jump")
	elif Input.get_axis("input_left", "input_right") != 0:
		central.change_state("Run")
	elif Input.is_action_pressed("input_down"):
		central.player_sprite.animation = "crouch"
	else:
		central.player_sprite.animation = "idle"
	if !central.is_on_floor():
		central.change_state("Jump")
