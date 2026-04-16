# Base class for all states in a state machine

extends Node
class_name base_state
# Reference machine's node controlled by this state
var central

# Called when entering this state
func enter_state(central_node):
	# Store the reference to the machine's central node
	central = central_node

# Called when exiting this state
func exit_state():
	pass

func handle_input(_delta):
	pass # No input handling in base state
	# Each specific state has its own input handling
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
