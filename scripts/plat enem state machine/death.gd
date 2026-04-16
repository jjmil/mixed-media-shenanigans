extends base_state


# Called when entering this state
func enter_state(central_node):
	super(central_node) # Correct way to call the parent class method
	central.score_change()
	central.speed = 0
	central.collider.disabled = true
	central.sprite.animation = "death"
	central.sprite.play()
	

func exit_state():
	pass
