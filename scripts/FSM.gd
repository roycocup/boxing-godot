extends Node

enum states {IDLE, LEFT, RIGHT, HIT, PAUSE}
enum events {LEFT, RIGHT, IDLE, HIT, PAUSE}

var registered_states = []
var current_state = null
var next_state = null

func get_state():
	return current_state

func assert_state(state):
	if get_state() == state: return true
	return false

func add_state(state, allowed):	
	var s = State.new()
	s.current = state
	s.allowed = allowed
	registered_states.append(s)

# check the event we are passing is allowed in current_state
# and if it is, set it as the new current state
func handle(event):
	var state = registered_states[current_state]
	# open the dictionary for the current state
	for link in state.allowed:
		# if the event matches the one being handled...
		if link.event == event:
			# set the current state to the other property (to_state)
			current_state = link.to_state
		
	
class State:
	var current = null
	var allowed = [{"event":null, "to_state":null}]