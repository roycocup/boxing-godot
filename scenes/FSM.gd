extends Node

enum states {IDLE, LEFT, RIGHT, HIT}
enum events {LEFT, RIGHT, IDLE}

var registered_states = []
var current_state = null
var next_state = null

func add_state(state, allowed):	
	var s = State.new()
	s.current = state
	s.allowed = allowed
	registered_states.append(s)

func handle(event):
	var state = registered_states[current_state]
	for link in state.allowed:
		if link.event == event:
			current_state = state.allowed[event].to_state
		
	
class State:
	var current = null
	var allowed = [{"event":null, "to_state":null}]