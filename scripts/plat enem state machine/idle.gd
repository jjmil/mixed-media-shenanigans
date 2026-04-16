extends base_state

# Called when entering this state
func enter_state(central_node):
	super(central_node) # Correct way to call the parent class method
	central.sprite.animation = "idle"
	central.sprite.play()
	central.speed = 0
	
