extends base_state


# var player = central

# Called when entering this state
func enter_state(player_node):
	super(player_node) # Correct way to call the parent class method
	central.velocity.x = 0
	central.velocity.y = 0
	central.player_sprite.rotation_degrees = 0
	central.player_sprite.animation = "death"
	
	get_tree().create_timer(1.0).timeout.connect(func(): get_tree().reload_current_scene())

func handle_input(_delta):
	pass
